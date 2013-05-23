DssRm.Views.GroupShow ||= {}

class DssRm.Views.GroupShow extends Backbone.View
  tagName: "div"
  
  events:
    "click a#apply": "save"
    "click button#group_rule_add": "addRule"
    "click button#remove_group_rule": "removeRule"
    "hidden": "cleanUpModal"
    "click #delete": "deleteEntity"

  initialize: ->
    @$el.html JST["templates/entities/show_group"](model: @model)
    @listenTo @model, "change", @render
    readonly = @model.isReadOnly()
    
    @$("input[name=owners]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly

    @$("input[name=operators]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly

    @$("input[name=members]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
    
    @renderRules()

  render: ->
    readonly = @model.isReadOnly()
    
    # Summary tab
    @$("h3").html @model.escape("name")
    @$("input[name=name]").val @model.get("name")
    @$("textarea[name=description]").val @model.escape("description")
    @$("span#group_member_count").html @model.get("members").length
    
    owners_tokeninput = @$("input[name=owners]")
    owners_tokeninput.tokenInput "clear"
    _.each @model.get("owners"), (owner) ->
      owners_tokeninput.tokenInput "add",
        id: owner.id
        name: owner.name
    
    operators_tokeninput = @$("input[name=operators]")
    operators_tokeninput.tokenInput "clear"
    _.each @model.get("operators"), (operator) ->
      operators_tokeninput.tokenInput "add",
        id: operator.id
        name: operator.name
    
    members_tokeninput = @$("input[name=members]")
    members_tokeninput.tokenInput "clear"
    _.each @model.get("members"), (member) ->
      members_tokeninput.tokenInput "add",
        id: member.id
        name: member.name
    
    @$("span#csv-download>a").attr "href", Routes.entity_path(@model.id, {format: 'csv'})
    
    if DssRm.admin_logged_in() || @model.relationship()
      @$("#delete").show()
    
    if readonly
      @$('.token-input-list-facebook').readonly()
      @$('input').readonly()
      @$('textarea').readonly()
    
    @
  
  renderRules: ->
    rules_table = @$("table#rules tbody")
    rules_table.empty()
    _.each @model.get("rules"), (rule, i) =>
      rules_table.append @renderRule(rule)
    
    if @model.get("rules").length is 0
      @$("table#rules tbody").hide()
    else
      @$("table#rules tbody").show()
    
    @
  
  # Renders a single rule. Does not add to DOM.
  renderRule: (rule) ->
    $rule = $(JST["templates/entities/group_rule"]())
    
    $rule.data "rule_id", rule.id
    $rule.find("td:nth-child(1) select").val rule.column
    $rule.find("td:nth-child(2) select").val rule.condition
    $rule.find("td:nth-child(3) input").val rule.value
    
    $rule.find("td:nth-child(3) input").typeahead
      minLength: 2
      sorter: (items) -> # required to keep the order given to process() in 'source'
        items
  
      highlighter: (item) ->
        item = item.split("####")[1] # See: https://gist.github.com/3694758 (FIXME when typeahead supports passing objects)
        query = @query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&")
        item.replace new RegExp("(" + query + ")", "ig"), ($1, match) ->
          "<strong>" + match + "</strong>"
  
      source: @ruleSearch
      updater: (item) =>
        @ruleSearchResultSelected item, @
    
    return $rule

  save: (e) ->
    e.preventDefault()
    
    status_bar.show 'Saving ...'

    @model.save
      name: @$('input[name=name]').val()
      description: @$('textarea[name=description]').val()
      owners: @$('input[name=owners]').tokenInput('get')
      operators: @$('input[name=operators]').tokenInput('get')
      members: @$('input[name=members]').tokenInput('get')
      rules: _.map($('table#rules>tbody>tr'), (el, i) ->
        id: $(el).data('rule_id')
        column: $(el).find("#column").val(),
        condition: $(el).find("#condition").val(),
        value: $(el).find("#value").val()
      )
    ,
      success: ->
        status_bar.hide()
      error: ->
        status_bar.show 'An error occurred while saving.', 'error'
      #silent: true

  deleteEntity: ->
    @$el.fadeOut()
    
    bootbox.confirm 'Are you sure you want to delete ' + @model.escape('name') + '?', (result) =>
      @$el.fadeIn()
      if result
        # delete the application and dismiss the dialog
        @model.destroy()
        
        # dismiss the dialog
        @$(".modal-header a.close").trigger "click"

    false

  addRule: (e) ->
    rules_table = @$("table#rules tbody")
    rules_table.show() # it will be hidden if there are no rules already
    rules_table.append @renderRule({ id: null, column: null, condition: null, value: null })

  removeRule: (e) ->
    rule_id = $(e.target).parents("tr").data("rule_id")
    @model.set
      rules: _.reject(@model.get("rules"), (r) ->
        r.id is rule_id
      )
    ,
      silent: true
    
    $(e.target).parents("tr").remove()

  cleanUpModal: ->
    @remove()
    
    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate "index"
  
  # Populates the sidebar search with results via async call
  ruleSearch: (query, process, e) ->
    lookahead_type = @$element.parents("tr").find("td:first select").val()
    lookahead_url = ""
    switch lookahead_type
      when "major"
        lookahead_url = Routes.majors_path()
      when "ou"
        lookahead_url = Routes.ous_path()
      when "loginid"
        lookahead_url = Routes.people_path()
      when "title"
        lookahead_url = Routes.titles_path()
      when "affiliation"
        lookahead_url = Routes.affiliations_path()
      when "classification"
        lookahead_url = Routes.classifications_path()
    $.ajax(
      url: lookahead_url
      data:
        q: query

      type: "GET"
    ).always (data) ->
      entities = []
      _.each data, (entity) ->
        if lookahead_type is "loginid"
          entities.push entity.id + "####" + entity.loginid
        else
          entities.push entity.id + "####" + entity.name

      process entities


  ruleSearchResultSelected: (item) ->
    parts = item.split("####")
    id = parseInt(parts[0])
    label = parts[1]
    label

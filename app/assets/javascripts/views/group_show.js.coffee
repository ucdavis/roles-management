DssRm.Views.GroupShow ||= {}

class DssRm.Views.GroupShow extends Backbone.View
  tagName: "div"
  className: "modal"
  id: "entityShowModal"
  
  events:
    "click #apply"                   : "save"
    "click button#group_rule_add"    : "addRule"
    "click button#remove_group_rule" : "removeRule"
    "hidden"                         : "cleanUpModal"
    "click #delete"                  : "deleteEntity"
    "shown"                          : "adjustOverflow"

  initialize: ->
    @$el.html JST["templates/entities/show_group"](model: @model)
    @listenTo @model, "sync", @render
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
      onAdd: (item) =>
        # Any members added via this interaction will be explicit members
        @model.set('explicit_members', @model.get('explicit_members').push
          id: item.id
          loginid: item.loginid
          name: item.name
        )
      onDelete: (item) =>
        # Did they delete an explicit member or calculated method?
        # Calculated members being deleted require a new rule be created
        if item.calculated
          # Calculated member requires we make a new rule
          $rule = @addRule()
          $rule.find('select#column').val('loginid')
          $rule.find('select#condition').val('is not')
          $rule.find('input#value').val(item.loginid)
        else
          # Explicit member is simply removed from the list, no rule needed
          @model.set('explicit_members', _.filter(@model.get('explicit_members'), (m) =>
            m.id != item.id
          ))

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
    _.each @model.get("calculated_members"), (member) ->
      members_tokeninput.tokenInput "add",
        id: member.id
        name: member.name
        loginid: member.loginid
        calculated: true
        class: "calculated"
    _.each @model.get("explicit_members"), (member) ->
      members_tokeninput.tokenInput "add",
        id: member.id
        name: member.name
        loginid: member.loginid
        class: "explicit"
    
    @$("a#csv-download").attr "href", Routes.entity_path(@model.id, {format: 'csv'})
    
    if DssRm.admin_logged_in() || @model.relationship()
      @$("#delete").show()
    
    if readonly
      @$('.token-input-list-facebook').readonly()
      @$('input').readonly()
      @$('textarea').readonly()
    
    @renderRules()
    
    @
  
  renderRules: ->
    rules_table = @$("table#rules tbody")
    rules_table.empty()
    _.each @model.get("rules"), (rule, i) =>
      rules_table.append @renderRule(rule)
    
    if @model.get("rules").length is 0
      rules_table.hide()
    else
      rules_table.show()
    
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
    
    @$('#apply').attr('disabled', 'disabled').html('Saving ...')

    # tokenInput('get') contains both explicit and calculated members.
    # Calculatedness is indicated by a flag inserted at render time.
    # Filter the list down to only explicit members - these are the only ones we save.
    # The others come from rules.
    explicit_tokeninput_members = _.filter(@$('input[name=members]').tokenInput('get'), (m) ->
      m.calculated != true
    )

    # Note: the _.filter() on rules is to avoid saving empty rules (rules with no value set)
    @model.save
      name: @$('input[name=name]').val()
      description: @$('textarea[name=description]').val()
      owners: @$('input[name=owners]').tokenInput('get')
      operators: @$('input[name=operators]').tokenInput('get')
      explicit_members: explicit_tokeninput_members
      rules: _.filter(_.map($('table#rules>tbody>tr'), (el, i) ->
        id: $(el).data('rule_id')
        column: $(el).find("#column").val(),
        condition: $(el).find("#condition").val(),
        value: $(el).find("#value").val()
      ), (r) ->
        r.value != ""
      )
    ,
      success: ->
        @$('#apply').removeAttr('disabled').html('Apply Changes')
      error: ->
        @$('#apply').addClass('btn-danger').html('Error')

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

  # Renders a new rule and returns jQuery object
  addRule: (e) ->
    rules_table = @$("table#rules tbody")
    rules_table.show() # it will be hidden if there are no rules already
    $rule = @renderRule({ id: null, column: null, condition: null, value: null })
    rules_table.append $rule
    return $rule

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
  
  # Due to a bug in Bootstrap 2.x modals, we need to adjust
  # the overflow to be off when using tokeninput tabs but
  # on when using typeahead tabs
  adjustOverflow: (e) ->
    switch $(e.target).attr('href')
      when '#rules'
        @$('.modal-body').css('overflow-y', 'visible')
      else
        @$('.modal-body').css('overflow-y', 'hidden')
  
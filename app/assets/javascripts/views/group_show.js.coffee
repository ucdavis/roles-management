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
    "change table#rules input"       : "persistRuleChanges"
    "change table#rules select"      : "persistRuleChanges"

  initialize: ->
    @$el.html JST["templates/entities/show_group"](model: @model)
    @listenTo @model, "sync", @render
    readonly = @model.isReadOnly()
    
    @$("input[name=owners]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        @model.owners.add
          id: item.id
          name: item.name
      onDelete: (item) =>
        @model.owners.remove(item.id)

    @$("input[name=operators]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        @model.operators.add
          id: item.id
          name: item.name
      onDelete: (item) =>
        @model.operators.remove(item.id)

    @$("input[name=memberships]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        @model.memberships.add
          calculated: false
          loginid: item.loginid
          entity_id: item.id
          group_id: @model.get('id')
          name: item.name
      onDelete: (item) =>
        # Did they delete a normal member or calculated member?
        # Deleting calculated members requires a new rule be created
        if item.calculated
          # Calculated member requires a new rule
          @model.rules.add
            id: 'new_' + (new Date).getTime()
            column: 'loginid'
            condition: 'is not'
            value: item.loginid
          @renderRules()
        else
          # Normal member being removed - no rule needed
          membership = @model.memberships.get(item.id)
          membership.set('_destroy', true)

  render: ->
    readonly = @model.isReadOnly()
    
    # Summary tab
    @$("h3").html @model.escape("name")
    @$("input[name=name]").val @model.get("name")
    @$("textarea[name=description]").val @model.get("description")
    @$("span#group_member_count").html @model.memberships.length
    
    owners_tokeninput = @$("input[name=owners]")
    owners_tokeninput.tokenInput "clear"
    @model.owners.each (owner) ->
      unless owner.get('_destroy')
        owners_tokeninput.tokenInput "add",
          id: owner.get('id')
          name: owner.get('name')
    
    operators_tokeninput = @$("input[name=operators]")
    operators_tokeninput.tokenInput "clear"
    @model.operators.each (operator) ->
      unless operator.get('_destroy')
        operators_tokeninput.tokenInput "add",
          id: operator.get('id')
          name: operator.get('name')
    
    members_tokeninput = @$("input[name=memberships]")
    members_tokeninput.tokenInput "clear"
    @model.memberships.each (membership) ->
      unless membership.get('_destroy')
        members_tokeninput.tokenInput "add",
          id: membership.id
          entity_id: membership.get('entity_id')
          name: membership.get('name')
          loginid: membership.get('loginid')
          calculated: membership.get('calculated')
          class: (if membership.get('calculated') then "calculated" else "")
    
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
    @model.rules.each (rule, i) =>
      unless rule.get('_destroy')
        rules_table.append @renderRule(rule)
    
    if @model.rules.length is 0
      rules_table.hide()
    else
      rules_table.show()
    
    @
  
  # Renders a single rule. Does not add to DOM.
  renderRule: (rule) ->
    $rule = $(JST["templates/entities/group_rule"]())
    
    $rule.data "rule_cid", rule.cid
    $rule.find("td:nth-child(1) select").val rule.get('column')
    $rule.find("td:nth-child(2) select").val rule.get('condition')
    $rule.find("td:nth-child(3) input").val rule.get('value')
    
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

    # Ensure @model.rules is up-to-date
    _.each $('table#rules>tbody>tr'), (el, i) =>
      cid = $(el).data('rule_cid')
      rule = @model.rules.get(cid)
      rule.set
        column: $(el).find("#column").val()
        condition: $(el).find("#condition").val()
        value: $(el).find("#value").val()

    # Note: the _.filter() on rules is to avoid saving empty rules (rules with no value set)
    @model.save
      name: @$('input[name=name]').val()
      description: @$('textarea[name=description]').val()
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
    @model.rules.add {}
      #id: 'new_' + (new Date).getTime()
    @renderRules()

  removeRule: (e) ->
    rule_cid = $(e.target).parents("tr").data("rule_cid")
    rule = @model.rules.get rule_cid
    rule.set('_destroy', true)
    @renderRules()

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

  # Copies the attributes of rules out of the DOM and into our model
  persistRuleChanges: (e) ->
    rule_cid = $(e.target).parents("tr").data("rule_cid")
    rule = @model.rules.get rule_cid
    
    switch $(e.target).attr('id')
      when 'column'
        rule.set 'column', $(e.target).val(), { silent: true }
      when 'condition'
        rule.set 'condition', $(e.target).val(), { silent: true }
      when 'value'
        rule.set 'value', $(e.target).val(), { silent: true }

DssRm.Views.GroupShow ||= {}

class DssRm.Views.GroupShow extends Backbone.View
  tagName: "div"
  
  events:
    "click a#apply": "save"
    "click button#group_rule_add": "addRule"
    "click button#remove_group_rule": "removeRule"
    "change table#rules select": "storeRuleChanges"
    "change table#rules input": "storeRuleChanges"
    "hidden": "cleanUpModal"
    "click #delete": "deleteEntity"

  initialize: ->
    @$el.html JST["entities/show_group"](model: @model)
    @listenTo @model, "change", @render
    readonly = @model.isReadOnly()
    
    @$("input[name=owners]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        owners = @model.get("owners")
        unless _.find(owners, (i) ->
          i.id is item.id
        )
          # onAdd is triggered by the .tokenInput("add") lines in render,
          # so we need to ensure this actually is a new item
          owners.push item
          @model.set "owners", owners, {silent: true}
    
      onDelete: (item) =>
        owners = _.filter(@model.get("owners"), (owner) ->
          owner.id isnt item.id
        )
        @model.set "owners", owners, {silent: true}

    @$("input[name=operators]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        operators = @model.get("operators")
        unless _.find(operators, (i) ->
          i.id is item.id
        )
          # onAdd is triggered by the .tokenInput("add") lines in render,
          # so we need to ensure this actually is a new item
          operators.push item
          @model.set "operators", operators, {silent: true}

      onDelete: (item) =>
        operators = _.filter(@model.get("operators"), (operator) ->
          operator.id isnt item.id
        )
        @model.set "operators", operators, {silent: true}

    @$("input[name=members]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        members = @model.get("members")
        unless _.find(members, (i) ->
          i.id is item.id
        )
          # onAdd is triggered by the .tokenInput("add") lines in render,
          # so we need to ensure this actually is a new item
          members.push item
          @model.set "members", members, {silent: true}

      onDelete: (item) =>
        members = _.filter(@model.get("members"), (member) ->
          member.id isnt item.id
        )
        @model.set "members", members, {silent: true}

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
    
    # Rules tab
    rules_table = @$("table#rules tbody")
    rules_table.empty()
    _.each @model.get("rules"), (rule, i) ->
      $rule = $(JST["entities/group_rule"]())
      $rule.find("td:nth-child(1) select").val rule.column
      $rule.find("td:nth-child(2) select").val rule.condition
      $rule.find("td:nth-child(3) input").val rule.value
      $rule.data "rule_id", rule.id
      rules_table.append $rule

    if @model.get("rules").length is 0
      @$("table#rules tbody").hide()
    else
      @$("table#rules tbody").show()
    @$("table#rules tbody tr").each (i, e) ->
      $(e).find("input#value").typeahead
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
    
    if readonly
      @$('.token-input-list-facebook').readonly()
      @$('input').readonly()
      @$('textarea').readonly()

    @

  save: (e) ->
    status_bar.show "Saving ..."

    @model.save
      name: @$("input[name=name]").val()
      description: @$("textarea[name=description]").val()
    ,
      success: ->
        status_bar.hide()
      error: ->
        status_bar.show "An error occurred while saving.", "error"
      silent: true
    
    false

  deleteEntity: ->
    @$el.fadeOut()
    
    bootbox.confirm "Are you sure you want to delete " + @model.escape("name") + "?", (result) =>
      @$el.fadeIn()
      if result
        # delete the application and dismiss the dialog
        @model.destroy()
        
        # dismiss the dialog
        @$(".modal-header a.close").trigger "click"

    false

  addRule: (e) ->
    updated_rules = _.clone(@model.get("rules"))
    
    # the false ID simply needs to be unique in case the 'remove' button is hit - our backend will provide a proper ID on saving
    updated_rules.push
      column: "ou"
      condition: "is"
      value: ""
      id: "new_" + Math.round((new Date()).getTime())

    @model.set rules: updated_rules

  removeRule: (e) ->
    rule_id = $(e.target).parents("tr").data("rule_id")
    @model.set rules: _.reject(@model.get("rules"), (r) ->
      r.id is rule_id
    )

  
  # Copies values off the DOM into this.model
  storeRuleChanges: (e) ->
    rule_id = $(e.target).parents("tr").data("rule_id")
    column = $(e.target).parents("tr").children("td:nth-child(1)").find("select").val()
    condition = $(e.target).parents("tr").children("td:nth-child(2)").find("select").val()
    value = $(e.target).parents("tr").children("td:nth-child(3)").find("input").val()
    @model.set rules: _.map(@model.get("rules"), (r) ->
      if r.id is rule_id
        r.column = column
        r.condition = condition
        r.value = value
      r
    )

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

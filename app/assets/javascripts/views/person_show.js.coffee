DssRm.Views.PersonShow ||= {}

class DssRm.Views.PersonShow extends Backbone.View
  tagName: "div"
  
  events:
    "click a#apply": "save"
    "click a#rescan": "rescan"
    "hidden": "cleanUpModal"
    "click #delete": "deleteEntity"

  initialize: ->
    @$el.html JST["entities/show_person"](model: @model)
    @listenTo @model, "change", @render
    readonly = @model.isReadOnly()
    
    @$("input[name=favorites]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        favorites = @model.get("favorites")
        unless _.find(favorites, (i) ->
          i.id is item.id
        )
          # onAdd is triggered by the .tokenInput("add") lines in render,
          # so we need to ensure this actually is a new item
          favorites.push item
          @model.set "favorites", favorites

      onDelete: (item) =>
        favorites = _.filter(@model.get("favorites"), (favorite) ->
          favorite.id isnt item.id
        )
        @model.set "favorites", favorites

    @$("input[name=groups]").tokenInput Routes.groups_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        group_memberships = @model.get("group_memberships")
        unless _.find(group_memberships.non_ous, (i) ->
          i.id is item.id
        )
          # onAdd is triggered by the .tokenInput("add") lines in render,
          # so we need to ensure this actually is a new item
          group_memberships.non_ous.push item
          @model.set "group_memberships", group_memberships

      onDelete: (item) =>
        group_memberships = @model.get("group_memberships")
        group_memberships.non_ous = _.filter(@model.get("group_memberships").non_ous, (group) ->
          group.id isnt item.id
        )
        @model.set "group_memberships", group_memberships

    @$("input[name=ous]").tokenInput Routes.ous_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: readonly
      onAdd: (item) =>
        group_memberships = @model.get("group_memberships")
        unless _.find(group_memberships.ous, (ou) ->
          ou.id is item.id
        )
          # onAdd is triggered by the .tokenInput("add") lines in render,
          # so we need to ensure this actually is a new item
          group_memberships.ous.push item
          @model.set "group_memberships", group_memberships

      onDelete: (item) =>
        group_memberships = @model.get("group_memberships")
        group_memberships.ous= _.filter(@model.get("group_memberships").ous, (ou) ->
          ou.id isnt item.id
        )
        @model.set "group_memberships", group_memberships

    $rolesTab = @$("fieldset#roles")
    _.each @model.roles.groupBy("application_name"), (roleset) =>
      app_name = roleset[0].get("application_name")
      app_id = roleset[0].get("application_id")
      $rolesTab.append "<p><label for=\"_token_input_" + app_id + "\">" + app_name + "</label><input type=\"text\" name=\"_token_input_" + app_id + "\" class=\"token_input\" /></p>"
      $rolesTab.find("input[name=_token_input_" + app_id + "]").tokenInput Routes.roles_path() + "?application_id=" + app_id,
        crossDomain: false
        defaultText: ""
        theme: "facebook"
        disabled: readonly
        onAdd: (item) =>
          roles = @model.get("roles")
          unless _.find(roles, (i) ->
            i.id is item.id
          )
            # onAdd is triggered by the .tokenInput("add") lines in render,
            # so we need to ensure this actually is a new item
            roles.push item
            @model.set "roles", roles
            @model.trigger "change"

        onDelete: (item) =>
          roles = _.filter(@model.get("roles"), (role) ->
            role.id isnt item.id
          )
          @model.set "roles", roles
          @model.trigger "change"

  render: ->
    readonly = @model.isReadOnly()
    
    @$("h3").html @model.escape("name")
    @$("h5").html @model.escape("byline")

    # Summary tab
    @$("input[name=first]").val @model.escape("first")
    @$("input[name=last]").val @model.escape("last")
    @$("input[name=email]").val @model.escape("email")
    @$("input[name=loginid]").val @model.escape("loginid")
    @$("input[name=phone]").val @model.escape("phone")
    @$("input[name=address]").val @model.get("address")
    
    favorites_tokeninput = @$("input[name=favorites]")
    favorites_tokeninput.tokenInput "clear"
    _.each @model.get("favorites"), (favorite) ->
      favorites_tokeninput.tokenInput "add",
        id: favorite.id
        name: favorite.name
        readonly: readonly

    groups_tokeninput = @$("input[name=groups]")
    groups_tokeninput.tokenInput "clear"
    _.each @model.get("group_memberships").non_ous, (group) ->
      groups_tokeninput.tokenInput "add",
        id: group.id
        name: group.name
        readonly: readonly

    ous_tokeninput = @$("input[name=ous]")
    ous_tokeninput.tokenInput "clear"
    _.each @model.get("group_memberships").ous, (ou) ->
      ous_tokeninput.tokenInput "add",
        id: ou.id
        name: ou.name
        readonly: readonly

    # Roles tab
    $rolesTab = @$("fieldset#roles")
    _.each @model.roles.groupBy("application_name"), (roleset) =>
      app_name = roleset[0].get("application_name")
      app_id = roleset[0].get("application_id")
      role_tokeninput = @$("input[name=_token_input_" + app_id + "]")
      role_tokeninput.tokenInput "clear"
      _.each roleset, (role) ->
        role_tokeninput.tokenInput "add",
          id: role.get("id")
          name: role.get("name")
          readonly: readonly

    if readonly
      @$('.token-input-list-facebook').readonly()
      @$('input').readonly()
      @$('textarea').readonly()

    @

  save: (e) ->
    unless @model.isReadOnly()
      status_bar.show "Saving ..."
      @model.set
        first: @$("input[name=first]").val()
        last: @$("input[name=last]").val()
        email: @$("input[name=email]").val()
        loginid: @$("input[name=loginid]").val()
        phone: @$("input[name=phone]").val()
        address: @$("input[name=address]").val()

      @model.save {},
        success: ->
          status_bar.hide()

        error: ->
          status_bar.show "An error occurred while saving.", "error"

      @model.trigger "change"

    false

  rescan: (e) ->
    status_bar.show "Re-scanning ..."
    
    # Disable all form elements while rescanning
    $('.modal-body form').children().each (i, el) ->
      $(el).attr("disabled", true)
    
    @model.fetch
      url: Routes.person_import_path @model.get('loginid')
      type: 'POST'
      success: (data) ->
        # Re-enable all form elements
        $('.modal-body form').children().each (i, el) ->
          $(el).attr("disabled", false)
        status_bar.hide()
      failure: (data) ->
        status_bar.show "An error occurred while re-scanning.", "error"
    
    false

  deleteEntity: ->
    unless @model.isReadOnly()
      @$el.fadeOut()
    
      bootbox.confirm "Are you sure you want to delete " + @model.escape("name") + "?", (result) =>
        @$el.fadeIn()
        if result
          # delete the application and dismiss the dialog
          @model.destroy()
        
          # dismiss the dialog
          @$(".modal-header a.close").trigger "click"

    false

  cleanUpModal: ->
    @remove()
    
    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate "index"

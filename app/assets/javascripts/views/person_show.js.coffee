DssRm.Views.PersonShow ||= {}

class DssRm.Views.PersonShow extends Backbone.View
  tagName: "div"
  className: "modal"
  id: "entityShowModal"
  
  events:
    "click #apply": "save"
    "click a#rescan": "rescan"
    "hidden": "cleanUpModal"
    "click #delete": "deleteEntity"

  initialize: ->
    @$el.html JST["templates/entities/show_person"](model: @model)
    @listenTo @model, "sync", @resetRolesTab
    @listenTo @model, "sync", @render
    @readonly = @model.isReadOnly()
    
    @initializeRelationsTab()
  
  initializeRelationsTab: ->
    @$("input[name=favorites]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: @readonly
      onAdd: (item) =>
        @model.set "favorites", @model.get("favorites").push(item)

      onDelete: (item) =>
        @model.set "favorites", _.filter(@model.get("favorites"), (favorite) ->
          favorite.id isnt item.id
        )

    @$("input[name=group_ownerships]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: @readonly
      # onAdd: (item) =>
      #   @model.set "favorites", @model.get("favorites").push(item)
      # 
      # onDelete: (item) =>
      #   @model.set "favorites", _.filter(@model.get("favorites"), (favorite) ->
      #     favorite.id isnt item.id
      #   )

    @$("input[name=group_operatorships]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: @readonly
      # onAdd: (item) =>
      #   @model.set "favorites", @model.get("favorites").push(item)
      # 
      # onDelete: (item) =>
      #   @model.set "favorites", _.filter(@model.get("favorites"), (favorite) ->
      #     favorite.id isnt item.id
      #   )

    @$("input[name=non_ou_group_memberships]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: @readonly
      # onAdd: (item) =>
      #   @model.set "favorites", @model.get("favorites").push(item)
      # 
      # onDelete: (item) =>
      #   @model.set "favorites", _.filter(@model.get("favorites"), (favorite) ->
      #     favorite.id isnt item.id
      #   )

    @$("input[name=ou_group_memberships]").tokenInput Routes.people_path(),
      crossDomain: false
      defaultText: ""
      theme: "facebook"
      disabled: @readonly
      # onAdd: (item) =>
      #   @model.set "favorites", @model.get("favorites").push(item)
      # 
      # onDelete: (item) =>
      #   @model.set "favorites", _.filter(@model.get("favorites"), (favorite) ->
      #     favorite.id isnt item.id
      #   )

  resetRolesTab: ->
    $rolesTab = @$("div#roles")
    $rolesTab.empty()
    
    console.log 'resetting roles tab'
    console.log @model.roles.length
    
    _.each @model.roles.groupBy("application_name"), (roleset) =>
      console.log roleset
      app_name = roleset[0].get("application_name")
      app_id = roleset[0].get("application_id")
      $rolesTab.append "<p><label for=\"_token_input_" + app_id + "\">" + app_name + "</label><input type=\"text\" name=\"_token_input_" + app_id + "\" class=\"token_input\" /></p>"
      $rolesTab.find("input[name=_token_input_" + app_id + "]").tokenInput Routes.roles_path() + "?application_id=" + app_id,
        crossDomain: false
        defaultText: ""
        theme: "facebook"
        disabled: @readonly
        onAdd: (item) => @model.roles.add item
        onDelete: (item) => @model.roles.remove item

  render: ->
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
    @model.favorites.each (favorite) =>
      favorites_tokeninput.tokenInput "add",
        id: favorite.get('id')
        name: favorite.get('name')
        readonly: @readonly
        
    group_ownership_tokeninput = @$("input[name=group_ownerships]")
    group_ownership_tokeninput.tokenInput "clear"
    @model.group_ownerships.each (ownership) =>
      group_ownership_tokeninput.tokenInput "add",
        id: ownership.get('id')
        name: ownership.get('name')
        readonly: @readonly

    group_operatorship_tokeninput = @$("input[name=group_operatorships]")
    group_operatorship_tokeninput.tokenInput "clear"
    @model.group_operatorships.each (operatorship) =>
      group_operatorship_tokeninput.tokenInput "add",
        id: operatorship.get('id')
        name: operatorship.get('name')
        readonly: @readonly
    
    non_ou_group_membership_tokeninput = @$("input[name=non_ou_group_memberships]")
    non_ou_group_membership_tokeninput.tokenInput "clear"
    _.each @model.nonOuGroupMemberships(), (membership) =>
      non_ou_group_membership_tokeninput.tokenInput "add",
        id: membership.get('id')
        name: membership.get('name')
        readonly: @readonly || not membership.get('explicit')
        class: (if membership.get('explicit') then "" else "calculated")

    ou_group_membership_tokeninput = @$("input[name=ou_group_memberships]")
    ou_group_membership_tokeninput.tokenInput "clear"
    _.each @model.ouGroupMemberships(), (membership) =>
      ou_group_membership_tokeninput.tokenInput "add",
        id: membership.get('id')
        name: membership.get('name')
        readonly: @readonly || not membership.get('explicit')
        class: (if membership.get('explicit') then "" else "calculated")

    # Roles tab
    $rolesTab = @$("div#roles")
    _.each @model.roles.groupBy("application_name"), (roleset) =>
      app_name = roleset[0].get("application_name")
      app_id = roleset[0].get("application_id")
      
      role_tokeninput = @$("input[name=_token_input_" + app_id + "]")
      role_tokeninput.tokenInput "clear"
      _.each roleset, (role) ->
        role_tokeninput.tokenInput "add",
          id: role.get("id")
          name: role.get("name")
          readonly: @readonly || not role.get('explicit')
          class: (if role.get('explicit') then "" else "calculated")
    
    if @readonly
      @$('.token-input-list-facebook').readonly()
      @$('input').readonly()
      @$('textarea').readonly()

    @

  save: (e) ->
    e.preventDefault()
    
    unless @model.isReadOnly()      
      @$('#apply').attr('disabled', 'disabled').html('Saving ...')
      
      @model.set
        first: @$("input[name=first]").val()
        last: @$("input[name=last]").val()
        email: @$("input[name=email]").val()
        loginid: @$("input[name=loginid]").val()
        phone: @$("input[name=phone]").val()
        address: @$("input[name=address]").val()

      @model.save {},
        success: ->
          @$('#apply').removeAttr('disabled').html('Apply Changes')

        error: ->
          @$('#apply').addClass('btn-danger').html('Error')

  rescan: (e) ->
    status_bar.show "Re-scanning ..."
    
    # Disable all form elements while rescanning
    $('.modal-body div.tab-content').children().each (i, el) ->
      $(el).attr("disabled", true)
    
    @model.fetch
      url: Routes.person_import_path @model.get('loginid')
      type: 'POST'
      success: (data) ->
        # Re-enable all form elements
        $('.modal-body div.tab-content').children().each (i, el) ->
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

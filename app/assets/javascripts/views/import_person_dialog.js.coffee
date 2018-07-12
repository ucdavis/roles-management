DssRm.Collections.ImportPersonDialogResults = Backbone.Collection.extend()

DssRm.Views.ImportPersonDialog = Backbone.View.extend(
  tagName: "div"
  className: "modal"
  id: "importPersonDialogModal"
  events:
    'shown'                    : 'loadResults'
    'hidden'                   : 'cleanUpModal'
    'click .form-search>button': 'performSearch'

  initialize: (options) ->
    @term = options.term
    @results = new DssRm.Collections.ImportPersonDialogResults()
    @listenTo @results, 'reset', @renderResults

    @$el.html JST["templates/application/import_person_dialog"]()

  render: ->
    # Set the search box to the desired term.
    @$('#term').val @term

    @

  renderResults: ->
    # Enable the form. renderResults disables it.
    @$('.form-search').children().each (i, el) ->
      $(el).removeAttr "disabled"

    @$('#results>tbody').empty()

    if @results.length
      # Render the result rows
      @results.each (r) =>
        if r.get('loginid') and r.get('email') and r.get('name')
          @$('#results>tbody').append(new DssRm.Views.ImportPersonDialogResult(person: r).render().el)
    else
      @$('#results>tbody').append(new DssRm.Views.ImportPersonDialogResult(person: null).render().el)


  # Async. call to load LDAP results
  loadResults: ->
    # Disable the form. renderResults will re-enable it.
    @$('.form-search').children().each (i, el) ->
      $(el).prop "disabled", true

    $.ajax
      type: "GET"
      url: Routes.people_search_path() + "?term=" + @term
      success: (data) =>
        @results.reset data
      error: (data) =>
        @$('table#results tbody').html('<tr><td colspan="4" style="text-align: center;"><h4>Error while loading results</h4></td></tr>')

  performSearch: (e) ->
    e.preventDefault()

    @term = @$('.form-search>input').val()

    @render()
    @loadResults()

  cleanUpModal: ->
    @remove()

    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate "index"
)

# Represents a single <tr> result in the above view
# Setting person to null will render a "No results" row
DssRm.Views.ImportPersonDialogResult = Backbone.View.extend(
  tagName: "tr"
  events:
    'click button': 'importResult'

  initialize: (options) ->
    @person = options.person
    if @person
      @listenTo @person, 'change', @render

  render: ->
    if @person
      html = "<td>#{@person.get('name')}</td><td>#{@person.get('email')}</td><td>#{@person.get('loginid')}</td>"

      if @person.get('imported')
        html += "<td><button class='btn' disabled>Imported</button></td>"
      else
        html += "<td><button class='btn btn-primary'>Import</button></td>"
    else
      html = "<td colspan=\"4\"><center><b>No results found</b></center></td>"

    @$el.html html

    @

  importResult: (e) ->
    e.preventDefault()

    @$('td>button').html('Importing ...').attr('disabled', 'disabled')

    $.ajax
      type: "POST"
      url: Routes.person_import_path(@person.get('loginid'))
      success: (data) =>
        @person.set 'imported', true
      error: (data) =>
        @$('td>button').html('Error').removeAttr('disabled')
        alert 'An error has occurred!'
)

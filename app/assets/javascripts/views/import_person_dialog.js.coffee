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
    
    @$el.html JST["application/import_person_dialog"]()

  render: ->
    # Set the search box to the desired term.
    @$('#term').val @term
    
    @
  
  renderResults: ->
    # Enable the form. renderResults disables it.
    @$('.form-search').children().each (i, el) ->
      $(el).removeAttr "disabled"

    @$('#results>tbody').empty()
    # Render the result rows
    @results.each (r) =>
      @$('#results>tbody').append(new DssRm.Views.ImportPersonDialogResult(person: r).render().el)
    

  # Async. call to load LDAP results
  loadResults: ->
    # Disable the form. renderResults will re-enable it.
    @$('.form-search').children().each (i, el) ->
      $(el).prop "disabled", true
      
    $.get(Routes.people_search_path() + "?q=" + @term, (data) =>
      @results.reset data
    )
  
  performSearch: (e) ->
    e.preventDefault()
    
    @term = @$('.form-search>input').val()
    
    @render()
    @loadResults()

  cleanUpModal: ->
    @remove
    
    # Need to change URL in case they want to open the same modal again
    Backbone.history.navigate "index"
)

# Represents a single <tr> result in the above view
DssRm.Views.ImportPersonDialogResult = Backbone.View.extend(
  tagName: "tr"
  events:
    'click button': 'importResult'
  
  initialize: (options) ->
    @person = options.person
    @listenTo @person, 'change', @render
  
  render: ->
    html = "<td>#{@person.get('name')}</td><td>#{@person.get('email')}</td><td>#{@person.get('loginid')}</td>"
    
    if @person.get('imported')
      html += "<td><button class='btn' disabled>Imported</button></td>"
    else
      html += "<td><button class='btn btn-primary'>Import</button></td>"
    
    @$el.html html
    
    @

  importResult: (e) ->
    e.preventDefault()
    
    $.ajax
      type: "POST"
      url: Routes.people_import_path()
      data: { loginid: @person.get('loginid') }
      success: (data) =>
        @person.set 'imported', true
      error: (data) =>
        alert 'An error has occurred!'
)

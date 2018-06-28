describe('Test that role assignments can be made', () => {
  const bookmarked_person = 'Sadaf Arshad';

  beforeEach(() => {
    Cypress.Cookies.preserveOnce('_DSS-RM_session');
  });

  it('Bookmark a person', () => {
    cy.visit('/applications');

    cy.get('input#search_sidebar.input-large.search-query')
    .type(bookmarked_person, {delay: 100})
    .should('have.value', bookmarked_person)
    .type('{enter}');
  });

  it('Highlight a role', () => {
    cy.get('div.role:first a').click({force: true});
  });

  it('Click on a favorite that is not assigned to the role',() => {
    cy.server()
      .route("POST", "/role_assignments").as("roleAssignments")
      .get('ul#pins li.person:first').click().click()
      .wait('@roleAssignments');
  });

  it('Favorite is moved to that top assigned section', () => {
    cy.get('li.person.highlighted').contains(bookmarked_person);
  });

  it('De-highlight the role', () => {
    cy.get('div.role:first a').click({force: true});
  });

  it('Highlight again and ensure the newly assigned favorite is still there',() => {
    cy.get('div.role:first a').click({force: true});
    cy.get('li.person.highlighted:last').contains(bookmarked_person);
  });

});

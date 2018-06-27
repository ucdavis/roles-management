describe('Test that role assignments can be made', () => {
  const bookmarked_person = 'Sadaf Arshad';

  beforeEach(() => {
    Cypress.Cookies.preserveOnce('_DSS-RM_session');
  });

  it('Bookmark a person', () => {
    cy.visit('/applications');

    cy.get('input#search_sidebar.input-large.search-query')
    .type(bookmarked_person).wait(15)
    .type('{enter}');
  });

  it('Highlight a role', () => {
    cy.visit('/applications');
    cy.get('div.role:first a').click({force: true});
  });

  it('Click on a favorite that is not assigned to the role',() => {
    cy.get('ul#pins li.person:first').click().click();
  });

  it('Favorite is moved to that top assigned section', () => {
    cy.wait(100).get('li.person.highlighted:last').contains(bookmarked_person);
  });

  it('De-highlight the role', () => {
    cy.get('div.role:first a').click({force: true});
  });

  it('Highlight again and ensure the newly assigned favorite is still there',() => {
    cy.get('div.role:first a').click({force: true});
    cy.get('li.person.highlighted:last').contains(bookmarked_person);
  });

});

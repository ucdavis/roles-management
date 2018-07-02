const BOOKMARKED_PERSON = 'Sadaf Arshad';

beforeEach(() => {
  Cypress.Cookies.preserveOnce('_DSS-RM_session');
});

describe('Test that role assignments can be made', () => {
  it('Bookmark a person', () => {
    cy.visit('/applications');

    cy.get('input#search_sidebar.input-large.search-query')
    .type(BOOKMARKED_PERSON, {delay: 100})
    .should('have.value', BOOKMARKED_PERSON)
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
    cy.get('li.person.highlighted').contains(BOOKMARKED_PERSON);
  });

  it('De-highlight the role', () => {
    cy.get('div.role:first a').click({force: true});
  });

  it('Highlight again and ensure the newly assigned favorite is still there',() => {
    cy.get('div.role:first a').click({force: true});
    cy.get('li.person.highlighted:last').contains(BOOKMARKED_PERSON);
  });

});

describe('Test that role assignments can be destroyed', () => {

  it('Highlight a role', () => {
    cy.visit('/applications');
    cy.get('div.role:first a').click({force: true});
  });

  it('Click on a role and delete',() => {
    cy.get('li.person.highlighted:last').click().click();

    cy.get('div.modal-header h3').should('contain', 'Are you sure?')
      .get('div.modal-body').contains(BOOKMARKED_PERSON)
      .get('div#cards h4#application-name:first').then(($application_name) => {
        const first_application_name =  $application_name.text();
        cy.get('div.modal-body').contains(first_application_name);
    });

    cy.get('div.role:first').then(($role_name) => {
      const first_role_name = $role_name.text();
      cy.get('div.modal-body').contains(first_role_name);
    });

    cy.get('div.modal-footer a#confirm.btn.btn-danger').click();
  });

  it('Highlight role again and ensure the newly assigned role is deleted',() => {
    cy.get('div.role:first a').click({force: true});
    cy.get('li.person.highlighted:last').should('not.contain', BOOKMARKED_PERSON);
  });

});

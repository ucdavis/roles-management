describe('Within application cards', () => {
  const RAILS_COOKIES_NAME = '_DSS-RM_session';

  beforeEach(() => {
    Cypress.Cookies.preserveOnce(RAILS_COOKIES_NAME);
  });

  it('can highlight a role', () => {
    cy.visit('/applications');

    beforeEach(function () {
      cy.get('div#sidebar ul#pins li:first span#name').invoke('text').as('bookmarked_person')
    });

    cy.get('div.role:first a').click({force: true});
  });

  it('can assign favorite a role', function (){
    cy.server()
      .route("POST", "/role_assignments").as("roleAssignments")
      .get('ul#pins li.person:first').click().click()
      .wait('@roleAssignments');

    cy.get('li.person.highlighted').contains(this.bookmarked_person);
  });

  it('can de-highlight the role', () => {
    cy.get('div.role:first a').click({force: true});
  });

  it('can re-highlight and ensure new assignment made', function (){
    cy.get('div.role:first a').click({force: true});
    cy.get('li.person.highlighted').contains(this.bookmarked_person);
  });

});

// FIXME: test assumes a person is already bookmarked.

context('Application cards', () => {
  const RAILS_COOKIES_NAME = '_DSS-RM_session';

  beforeEach(() => {
    Cypress.Cookies.preserveOnce(RAILS_COOKIES_NAME);
  });

  describe('Role assignment can be made by', () => {
    it('highlighting a role', () => {
      cy.visit('/applications');

      beforeEach(function () {
        cy.get('div#sidebar-area li.person:first span#name').invoke('text').as('bookmarked_person');
        cy.get('div.card:first div.role:first a').invoke('text').as('card_name');
        cy.get('div#cards h4#application-name:first').invoke('text').as('application_name');
      });

      cy.get('div.role:first a').click({force: true});
    });

    it('assigning role to favorite', function (){
      cy.server()
        .route("POST", "/role_assignments").as("roleAssignments")
        .get('ul#pins li.person:first').click().click()
        .wait('@roleAssignments');

      cy.get('li.person.highlighted').contains(this.bookmarked_person);
    });

    it('de-highlighting the role', () => {
      cy.get('div.role:first a').click({force: true});
    });

    it('re-highlighting to ensure new assignment was made', function (){
      cy.get('div.role:first a').click({force: true});
      cy.get('li.person.highlighted').contains(this.bookmarked_person);
    });
  });

  describe('Role assignment can be destroyed by', () => {
    it('highlighting a role', () => {
      cy.visit('/applications');
      cy.get('div.role:first a').click({force: true});
    });

    it('Click on a role and delete', function (){
      cy.get('ul#highlighted_pins.pins.disable-text-select')
        .contains(this.bookmarked_person).click().click()

      cy.get('div.modal-header h3').should('contain', 'Are you sure?');
      cy.get('div.modal-body').contains(this.bookmarked_person);
      cy.get('div.modal-body').contains(this.card_name);
      cy.get('div.modal-body').contains(this.application_name);

      cy.get('div.modal-footer a#confirm.btn.btn-danger').click();
    });

    it('Highlight role again and ensure the newly assigned role is deleted', function (){
      cy.get('div.role:first a').click({force: true});
      cy.get('li.person.highlighted').should('not.contain', this.bookmarked_person);
    });
  });
});

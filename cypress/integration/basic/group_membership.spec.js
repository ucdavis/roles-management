// FIXME: test assumes a group is already bookmarked.

describe('Group membership tab', () => {
  const RAILS_COOKIES_NAME = '_DSS-RM_session';
  const NEW_MEMBER = 'Sadaf Arshad';

  beforeEach(() => {
    Cypress.Cookies.preserveOnce(RAILS_COOKIES_NAME);
  });

  it('can be opened', () => {
    cy.visit('/applications');

    beforeEach(function () {
        cy.get('div#sidebar-area li.group:first span#name').invoke('text').as('bookmarked_group');
    });

    cy.get('div#sidebar-area li.group:first a.entity-details-link:first').click({force: true});
    cy.get('div.modal-body ul.nav.nav-tabs li:nth-child(2) a').click();
  });

  it('can add a member', function (){
    cy.get('div.modal-header h3').contains(this.bookmarked_group);

    cy.get('p#members ul.token-input-list-facebook li:last input').click()
     .type(NEW_MEMBER, {delay: 500})
     .should('have.value', NEW_MEMBER)
     .type('{enter}');

     cy.get('div.modal-footer button#apply').click();
     cy.get('p#members').contains(NEW_MEMBER);
  });

  it('can be closed',() => {
    cy.get('div.modal-header a').click()
      .get('div#sidebar-area a.entity-details-link:first').click({force: true});
  });

  it('can be opened and new member exits',() => {
    cy.get('div.modal-body ul.nav.nav-tabs li:nth-child(2) a').click()
      .get('p#members').contains(NEW_MEMBER);
  });
});

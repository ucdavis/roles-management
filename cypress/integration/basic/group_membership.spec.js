describe('Test that group membership can be edited', () => {
  const BOOKMARKED_GROUP = 'All DSS IT Staff';
  const NEW_MEMBER = 'Sadaf Arshad';

  beforeEach(() => {
    Cypress.Cookies.preserveOnce('_DSS-RM_session');
  });

  it('Open a group modal', () => {
    cy.visit('/applications');

    cy.get('input#search_sidebar.input-large.search-query')
    .type(BOOKMARKED_GROUP,{delay: 100})
    .should('have.value', BOOKMARKED_GROUP)
    .type('{enter}');

    cy.get('div#sidebar-area a.entity-details-link:first').click({force: true});
  });

  it('Click the Membership tab',() => {
    cy.get('div.modal-body ul.nav.nav-tabs li:nth-child(2) a').click();
  });

  it('Add a member', () => {
    cy.get('p#members ul.token-input-list-facebook li:last input').click()
     .type(NEW_MEMBER, {delay: 500})
     .should('have.value', NEW_MEMBER)
     .type('{enter}');
  });

  it('Click Apply Changes', () => {
    cy.get('div.modal-footer button#apply').click();
  });

  it('Ensure the member is still there',() => {
    cy.get('p#members').contains(NEW_MEMBER);
  });

  it('Close the modal and re-open it',() => {
    cy.get('div.modal-header a').click()
      .get('div#sidebar-area a.entity-details-link:first').click({force: true});
  });

  it('Ensure the member is still there',() => {
    cy.get('div.modal-body ul.nav.nav-tabs li:nth-child(2) a').click()
      .get('p#members').contains(NEW_MEMBER);
  });

});

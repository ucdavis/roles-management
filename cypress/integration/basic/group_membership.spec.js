describe('Test that group membership can be edited', () => {
  const bookmarked_group = 'All DSS IT Staff';
  const new_member = 'Sadaf Arshad';

  beforeEach(() => {
    Cypress.Cookies.preserveOnce('_DSS-RM_session');
  });

  it('Open a group modal', () => {
    cy.visit('/applications');

    cy.get('input#search_sidebar.input-large.search-query')
    .type(bookmarked_group,{delay: 100})
    .should('have.value', bookmarked_group)
    .type('{enter}');

    cy.get('div#sidebar-area a.entity-details-link:first').click({force: true});
  });

  it('Click the Membership tab',() => {
    cy.get('div.modal-body ul.nav.nav-tabs li:nth-child(2) a').click();
  });

  it('Add a member', () => {
    cy.get('p#members ul.token-input-list-facebook li:last input').click()
     .type(new_member, {delay: 500})
     .should('have.value', new_member)
     .type('{enter}');
  });

  it('Click Apply Changes', () => {
    cy.get('div.modal-footer button#apply').click();
  });

  it('Ensure the member is still there',() => {
    cy.get('p#members').contains(new_member);
  });

  it('Close the modal and re-open it',() => {
    cy.get('div.modal-header a').click()
      .get('div#sidebar-area a.entity-details-link:first').click({force: true});
  });

  it('Ensure the member is still there',() => {
    cy.get('div.modal-body ul.nav.nav-tabs li:nth-child(2) a').click()
      .get('p#members').contains(new_member);
  });

});

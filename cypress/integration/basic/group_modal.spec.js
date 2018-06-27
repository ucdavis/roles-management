describe('Test that the group show modal can be opened', () => {
  const bookmarked_group = 'All DSS IT Developers';

  it('Create a group', () => {
    cy.visit('/applications');

    cy.get('input#search_sidebar.input-large.search-query')
    .type(bookmarked_group).wait(5)
    .type('{enter}');
  });

  it('Clicking a group open icon shows the modal.',() => {
    cy.get('div#sidebar-area a.entity-details-link:first').click({force: true});
  });

  it('The modal has a header which matches the group name.', () => {
    cy.get('div.modal-header h3').should('contain', bookmarked_group);
  });

  it('The modal has five tabs.', () => {
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(1)').should('contain', 'Summary');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(2)').should('contain', 'Relations');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(3)').should('contain', 'Roles');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(4)').should('contain', 'Rules');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(5)').should('contain', 'Activity');
  });

});

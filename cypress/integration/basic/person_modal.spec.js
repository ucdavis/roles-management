describe('Test that the person show modal can be opened', () => {
  const bookmarked_person = 'Sadaf Arshad';

  it('Bookmark a person', () => {
    cy.visit('/applications');

    cy.get('input#search_sidebar.input-large.search-query')
    .type(bookmarked_person, {delay: 100})
    .should('have.value', bookmarked_person)
    .type('{enter}');
  });

  it('Clicking a bookmarked person\'s open icon should reveal a modal',() => {
    cy.get('div#sidebar-area a.entity-details-link:first').click({force: true});
  });

  it('The modal should have the person\'s name.', () => {
    cy.get('div.modal-header h3').should('contain', bookmarked_person);
  });

  it('The modal should have four tabs.', () => {
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(1)').should('contain', 'Summary');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(2)').should('contain', 'Relations');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(3)').should('contain', 'Roles');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(4)').should('contain', 'Activity');
  });

});

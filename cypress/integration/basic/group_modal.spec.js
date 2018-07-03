  describe('Group show modal', () => {
    const BOOKMARKED_GROUP = 'All DSS IT Staff';
    const KEYBOARD_TYPE_DELAY = 100;

    it('can be opened',() => {
      cy.visit('/applications');

      cy.get('input#search_sidebar.input-large.search-query')
        .type(BOOKMARKED_GROUP, {delay: KEYBOARD_TYPE_DELAY})
        .should('have.value', BOOKMARKED_GROUP)
        .type('{enter}');

      cy.get('div#sidebar-area a.entity-details-link:first').click({force: true});
    });

    it('has a header group name', () => {
      cy.get('div.modal-header h3').should('contain', BOOKMARKED_GROUP);
    });

    it('has five tabs', () => {
      cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(1)').should('contain', 'Summary');
      cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(2)').should('contain', 'Relations');
      cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(3)').should('contain', 'Roles');
      cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(4)').should('contain', 'Rules');
      cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(5)').should('contain', 'Activity');
    });

  });

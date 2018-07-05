// FIXME: test assumes a group is already bookmarked.

describe('Group show modal', () => {
  it('can be opened', () => {
    cy.visit('/applications');

    beforeEach(function () {
       cy.get('div#sidebar-area li.group:first span#name').invoke('text').as('bookmarked_group');
    });
    cy.get('div#sidebar-area li.group:first a.entity-details-link:first').click({force: true});
  });

  it('has a header group name', function (){
    cy.get('div.modal-header h3').should('contain', this.bookmarked_group);
  });

  it('has five tabs', () => {
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(1)').should('contain', 'Summary');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(2)').should('contain', 'Relations');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(3)').should('contain', 'Roles');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(4)').should('contain', 'Rules');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(5)').should('contain', 'Activity');
  });
});

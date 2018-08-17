// FIXME: test assumes a person is already bookmarked.

describe('Person show modal', () => {
  it('can be opened', () => {
    cy.visit('/applications');

    beforeEach(function () {
      cy.get('div#sidebar-area li.person:first span#name').invoke('text').as('bookmarked_person');
    });

    cy.get('div#sidebar-area li.person:first a.entity-details-link:first').click({force: true});
  });

  it('has a header group name', function (){
    cy.get('div.modal-header h3').should('contain', this.bookmarked_person);
  });

  it('has four tabs', () => {
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(1)').should('contain', 'Summary');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(2)').should('contain', 'Relations');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(3)').should('contain', 'Roles');
    cy.get('div.tabbable.tabs-left ul.nav.nav-tabs li:nth-child(4)').should('contain', 'Activity');
  });
});

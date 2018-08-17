describe('Group show modal', () => {
  const GROUP_NAME = 'New Group #1';
  const NEW_GROUP_NAME = 'New Group #2';
  const RAILS_COOKIES_NAME = '_DSS-RM_session';

  beforeEach(() => {
    Cypress.Cookies.preserveOnce(RAILS_COOKIES_NAME);
  });

  it('can be opened', () => {
    cy.visit('/applications');

    cy.get('input#search_sidebar.input-large.search-query')
        .type(GROUP_NAME, {delay: 100})
        .get('ul.typeahead.dropdown-menu li:nth-child(2)')
        .trigger('mouseover')
        .click({force: true});

      cy.server()
        .route("GET", "**/entities/**").as("groupAssignment")
        .get('ul#pins.pins.disable-text-select')
        .contains(GROUP_NAME)
        .parent('li')
        .children('a.entity-details-link')
        .click({force: true});

      cy.wait('@groupAssignment')
        .its('url').should('include', '/entities/');
 });

  it('can change name', function (){
    cy.get('div.modal-header h3').should('contain', GROUP_NAME);

    cy.get('input.input-xlarge').clear()
      .type(NEW_GROUP_NAME, {delay: 100});

    cy.get('div.modal-footer button#apply').click();
  });

  it('can close the group modal',() => {
    cy.get('div.modal-header a.close').click();
  });

  it('open group modal again and ensure name is changed',() => {
    cy.get('ul#pins.pins.disable-text-select')
       .contains(NEW_GROUP_NAME)
       .parent('li')
       .children('a.entity-details-link')
       .click({force: true});

    cy.get('div.modal-header h3').should('contain', NEW_GROUP_NAME);

    cy.get('div.tab-content div#summary input').then(($name) => {
      const new_name = $name.val();
      cy.expect(new_name).contains(NEW_GROUP_NAME);
    });
  });
});

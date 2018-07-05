// FIXME: test assumes a group is already bookmarked.

describe('Group rules tab', () => {
  const RAILS_COOKIES_NAME = '_DSS-RM_session';
  const COLUMN = 'loginid';
  const CONDITION = 'is';
  const VALUE = 'jeremy';

  beforeEach(() => {
    Cypress.Cookies.preserveOnce(RAILS_COOKIES_NAME);
  });

  it('can be opened', () => {
    cy.visit('/applications');

    beforeEach(function () {
        cy.get('div#sidebar-area li.group:first span#name').invoke('text').as('bookmarked_group');
    });

    cy.get('div#sidebar-area li.group:first a.entity-details-link:first').click({force: true});
    cy.get('div.modal-body ul.nav.nav-tabs li:nth-child(4) a').click();
  });

  it("can add a rule = 'Login ID is jeremy' ", function (){
    cy.get('div.modal-header h3').contains(this.bookmarked_group);

    cy.get('p button.btn').click();
    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(1) select')
      .select(COLUMN);

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(2) select')
      .select(CONDITION);

      cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(3) input')
        .type(VALUE)
        .should('have.value', VALUE)
        .type('{enter}')
        .click();

      cy.get('div.modal-footer button#apply').click();
  });

  it('can ensure that the rule exists',() => {
    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(1) select').then(($column) => {
        const rule_column = $column.val();
        cy.expect(rule_column).contains(COLUMN);
    });

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(2) select').then(($condition) => {
        const rule_condition = $condition.val();
        cy.expect(rule_condition).contains(CONDITION);
    });

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(3) input').then(($value) => {
      const rule_value = $value.val();
      cy.expect(rule_value).contains(VALUE);
    });
  });

  it('can be closed',() => {
    cy.get('div.modal-header a.close').click();
  });

  it('can be opened again and new rule exists', function (){
    cy.get('div#sidebar-area li.group:first a.entity-details-link:first').click({force: true});
    cy.get('div.modal-body ul.nav.nav-tabs li:nth-child(4) a').click();

    cy.get('div.modal-header h3').contains(this.bookmarked_group);

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(1) select').then(($column) => {
        const rule_column = $column.val();
        cy.expect(rule_column).contains(COLUMN);
    });

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(2) select').then(($condition) => {
        const rule_condition = $condition.val();
        cy.expect(rule_condition).contains(CONDITION);
    });

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(3) input').then(($value) => {
      const rule_value = $value.val();
      cy.expect(rule_value).contains(VALUE);
    });
  });
});

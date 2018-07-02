describe('Test that group rules can be created', () => {
  const bookmarked_group = 'All DSS IT Staff';
  const column = 'loginid';
  const condition = 'is';
  const value = 'jeremy';

  beforeEach(() => {
    Cypress.Cookies.preserveOnce('_DSS-RM_session');
  });

  it('Open a group modal', () => {
    cy.visit('/applications');

    cy.get('input#search_sidebar.input-large.search-query')
      .type(bookmarked_group, {delay: 100})
      .should('have.value', bookmarked_group)
      .type('{enter}');

    cy.get('div#sidebar-area a.entity-details-link:first').click({force: true});
  });

  it('Click the "Rules" tab',() => {
    cy.get('div.modal-body ul.nav.nav-tabs li:nth-child(4) a').click();
  });

  it('Click Add Rule "Login ID is jeremy"', () => {
    cy.get('p button.btn').click();
    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(1) select')
      .select(column)

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(2) select')
      .select(condition)

      cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(3) input')
        .type(value)
        .should('have.value', value)
        .type('{enter}')
        .click()
  });

  it('Click "Apply Changes"',() => {
    cy.get('div.modal-footer button#apply').click();
  });

  it('Ensure that the rule exists after the save',() => {
    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(1) select').then(($column) => {
        const rule_column = $column.val();
        cy.expect(rule_column).contains(column);
    });

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(2) select').then(($condition) => {
        const rule_condition = $condition.val();
        cy.expect(rule_condition).contains(condition);
    });

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(3) input').then(($value) => {
      const rule_value = $value.val();
      cy.expect(rule_value).contains(value);
    });
  });

  it('Close the group modal',() => {
    cy.get('div.modal-header a.close').click();
  });

  it('Open it again and confirm that the group rule is still there',() => {
    cy.get('div#sidebar-area a.entity-details-link:first').click({force: true});
    cy.get('div.modal-body ul.nav.nav-tabs li:nth-child(4) a').click();

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(1) select').then(($column) => {
        const rule_column = $column.val();
        cy.expect(rule_column).contains(column);
    });

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(2) select').then(($condition) => {
        const rule_condition = $condition.val();
        cy.expect(rule_condition).contains(condition);
    });

    cy.get('div#rules.tab-pane.fade.active.in table#rules tr.fields:last td:nth-child(3) input').then(($value) => {
      const rule_value = $value.val();
      cy.expect(rule_value).contains(value);
    });
  });

});

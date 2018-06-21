describe('Homepage and modal window', () => {

  beforeEach(() => {
     cy.visit('');
  });

  it('Should go to /welcome and return HTTP 200',() => {
    cy.request({
      url: '/welcome',
      followRedirect: false  // turns off redirects
    })
    .then(($response) => {
      cy.expect($response.status).to.eq(200)
    });
  });

  it('Applications shows modal icon',() => {
    cy.visit('/applications');

    cy.get('div#cards h4#application-name:first').then(($name) => {
      const first_application_name =  $name.text();

      cy.get('div#cards a.application-link:first').click({force: true});
      cy.get('div.modal-header h3').should('contain', first_application_name);
    });
  });

});

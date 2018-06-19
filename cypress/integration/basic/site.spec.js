describe('Homepage and login', () => {

  beforeEach(() => {
     cy.visit('http://localhost:3000')
  })

it('Should go to /welcome and return HTTP 200',() => {
  cy.request({
    url: 'http://localhost:3000/welcome',
    followRedirect: false  // turns off redirects
  })
  .then((response) => {
     cy.expect(response.status).to.eq(200)
  })
})

it('Test that /applications redirects to CAS ',() => {
  const username = Cypress.env('userName')
  const password = Cypress.env('password')

  cy.request({
    method: 'POST',
    url: 'https://ssodev.ucdavis.edu/cas',
    form: true,
    body: {
      username,
      password,
      _eventId: 'submit',
      submit: 'LOGIN',
    }
  });
});

it('Applications shows modal icion',() => {
  cy.visit('http://localhost:3000/applications')
  cy.get('title').contains('Roles Management')
})

})

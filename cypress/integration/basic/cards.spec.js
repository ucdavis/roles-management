describe('Test that application cards are rendering correctly', () => {

  beforeEach(() => {
    cy.visit('')
  });

/* NEED TO FINISH THIS */
  it('Check that a div exists for each application',() => {
    cy.visit('/applications')

    cy.request({
      url: '/applications.json'
    })
    .then((response) => {
      expect(response.status).to.eq(200);
      const cards_obj = response.body

      cy.get('.card#id').each(($applicationId, i, $array) => {
        const Id_string = $applicationId[i].id
        const Id_number = parseInt(Id_string.match(/\d+/))

        var i;
        for(i = 1; i <= cards_obj.length; i++){

        }

      //  cy.expect($array).to.contain(cards_obj[i].id)

      });
    });


/*
      cy.get('.card').first().then(($applicationId) => {

      cy.expect($applicationId[0].id).to.eq('application_147')
        const Id_string = $applicationId[0].id
        const Id_number = parseInt(Id_string.match(/\d+/))

      cy.expect(Id_number).to.eq(147)
      //cy.expect(cards_obj[1].id).to.equal(Id_number)

      //cards_obj.results.find(item => item.id == 147)

      //cards_obj[i].id
      });
    });
*/
  });

//  debugger
//  console.log()


  it('Number of application cards must match number of applications',() => {
    cy.visit('/applications')

    cy.request({
      url: '/applications.json'
    })
    .then((response) => {
      expect(response.status).to.eq(200);
      const cards_obj = response.body

      cy.get('div#cards h4#application-name').then(($numCards) => {
        cy.expect($numCards.length).to.eq(cards_obj.length)
      });
    });
  });


  it('Check each application name matches the child',() => {
    cy.visit('/applications')

    cy.request({
      url: '/applications.json'
    })
    .then((response) => {
      expect(response.status).to.eq(200);
      const cards_obj = response.body

      cy.get('div#cards h4#application-name').each(($element, i, $name_array) => {
        cy.expect($name_array).to.contain(cards_obj[i].name)
      });
    });
  });

});

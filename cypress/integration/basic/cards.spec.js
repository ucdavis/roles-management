describe('Application cards', () => {
  it('contain a div tag',() => {
    cy.visit('/applications');

    cy.request({
      url: '/applications.json'
    })
    .then((response) => {
      expect(response.status).to.eq(200);
      const cards_obj = response.body;
      var count = -1;

      cy.get('div.card').each(($element, index, $list) => {
          const id = ($element).attr('id');
          const name = ($element).find('h4#application-name').text();

          for(var i=0; i <= cards_obj.length; i++) {
              var application_i = cards_obj[i];
              if(application_i["name"] == name){
                  cy.expect(id).to.contain(application_i["id"]);
                  count++;
                  break;
              };
          };
          cy.expect(count).to.eq(index);
      });
    });
  });

  it('matches the number of applications in the JSON feed',() => {
    cy.request({
      url: '/applications.json'
    })
    .then((response) => {
      expect(response.status).to.eq(200);
      const cards_obj = response.body;

     cy.get('div.card h4#application-name').then(($applicationCards) => {
        cy.expect($applicationCards.length).to.eq(cards_obj.length);
     });
    });
  });

  it('name matches the child',() => {
    cy.request({
      url: '/applications.json'
    })
    .then((response) => {
      expect(response.status).to.eq(200);
      const cards_obj = response.body;
      var count = 0;

     cy.get('div.card').each(($element, index, $list) => {
         const name = ($element).find('h4#application-name').text();

         for(var i=0; i <= cards_obj.length; i++) {
             var application_i = cards_obj[i];
             if(application_i["name"] == name) {
                 cy.expect(name).to.contain(application_i["name"]);
                 break;
             };
         };
      });
    });
  });
});

var DATA;

function decodeHtml(html) {
  var txt = document.createElement("textarea");
  txt.innerHTML = html;
  return txt.value;
};

describe('Application favorites', () => {
  it('get the canonical list',() => {
    cy.visit('/applications');

    cy.get('script[type="text/json"]').then(($dataList) => {
      var datatext = decodeHtml($dataList.text());
      var json_obj = JSON.parse(datatext);
      DATA = json_obj.current_user.favorites;
    });
  });

  it('matches the count of favorites in the JSON feed',() => {
    cy.get('ul#pins.pins.disable-text-select li').then(($pins) => {
       cy.expect($pins.length).to.eq(DATA.length);
    });
  });

  it('contain a div tag',() => {
    var count = -1;

    cy.get('div#sidebar ul#pins li').each(($element, index, $list) => {
      const name = ($element).find('span#name').text();

      for(var i=0; i < DATA.length; i++) {
          var pin_i = DATA[i];
          if(pin_i["name"] == name) {
              cy.expect(name).to.contain(pin_i["name"]);
              count++;
              break;
          };
      };
      cy.expect(count).to.eq(index);
    });
  });
});

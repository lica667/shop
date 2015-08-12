function getCategories(){  
  $.getJSON('/categories.json', function(json){
    $('#categories').children().remove();
    returnCategoriesTree(json['categories'], 'categories');
  });
};

function setSlides(){
  $("#slides").slidesjs({
    width: 940,
    height: 528,
    navigation: false
  });
};

function returnCategoriesTree(categories, id){  
  $.each( categories , function(index, value){
    $('#'+id).append("<li><a href = '/category?id="+value['id']+"'>" + value["name"] + "</a></li>")
    // console.log('id:' +id+ ' |name: ' + value["name"]);
    if (value['categories']) {
      $('#'+id).append("<ul id="+value["id"]+"></ul>")
      returnCategoriesTree(value['categories'], value["id"]);
    }
  });
};

function setCurrencyButtons () {
  $('.good_price').currency();
  $('#btn_usd').click(function(){
    changeGoodCurrency('usd');
  });
  $('#btn_eur').click(function(){
    changeGoodCurrency('eur');
  });
  $('#btn_byr').click(function(){
    changeGoodCurrency('byr');
  });  
};

function changeGoodCurrency (token) {
  $(".product").each(function(){
    $.getJSON('/change_currency?token='+token+'&id='+this.id, function(json){
      $('.product#'+json['id']).find('.good_price').text(json['cost']);
      setCurrency(token);
    });
  });
};

function setCurrency (token) {
  switch (token) {
    case 'usd':
      $('.good_price').currency({
        region: "USD",
        thousands: " ",
        decimals: 2
      });  
      break
    case 'eur':
      $('.good_price').currency({
        region: "EUR",
        thousands: " ",
        decimals: 2
      });
      break
    case 'byr':
      $('.good_price').currency({
        region: "BYR",
        thousands: " ",
        decimals: 0
      });
      break
    default:
      $('.good_price').currency({
        region: "USD",
        thousands: " ",
        decimals: 2
      }); 
  }
};
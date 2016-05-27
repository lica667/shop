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
  getCountryCode();
  $('#btn_usd').click(function(){
    changeGoodCurrency('USD');
  });
  $('#btn_eur').click(function(){
    changeGoodCurrency('EUR');
  });
  $('#btn_byr').click(function(){
    changeGoodCurrency('BY');
  });  
};

function changeGoodCurrency (token) {
  document.cookie = "currency = "+token
  $(".product").each(function(){
    $.getJSON('/change_currency?token='+token+'&id='+this.id, function(json){
      $('.product#'+json['id']).find('.good_price').text(json['cost']);
      setCurrency(token);
    });
  });
};

function setCurrency (token) {
  switch (token) {
    case 'USD':
      $('.good_price').currency({
        region: "USD",
        thousands: " ",
        decimals: 2
      });  
      break
    case 'EUR':
      $('.good_price').currency({
        region: "EUR",
        thousands: " ",
        decimals: 2
      });
      break
    case 'BY':
      $('.good_price').currency({
        region: "BY",
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

function getCookie(name) {
  var matches = document.cookie.match(new RegExp(
    "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
  ));
  return matches ? decodeURIComponent(matches[1]) : undefined;
}

function getCountryCode() {
  if (!getCookie('currency')){
    console.log("-----in ajax request----")
    jQuery.ajax( { 
      url: '//freegeoip.net/json/', 
      type: 'POST', 
      dataType: 'jsonp',
      success: function(location) {
        changeGoodCurrency(location.country_code)
        console.log("-----in ajax request 2 ----")
        console.log(location.country_code)
      }
    });
  } else {
    setCurrency(getCookie('currency'));
    console.log("--------out ajax request--------")
  }
}

function addToCart(){
  $(document).on('click', '#add_to_cart', function(){
    var quantity = $(this.parentNode).find('input').val()
    var id = $('.product-info').attr('id')
    // debugger;
    data = { 'id' : id, 'quantity': quantity }
    $.ajax({
      type: 'POST',
      url: '/add_to_cart',
      data: data,
      // success: success,
      dataType: 'json',
    });
  });
}
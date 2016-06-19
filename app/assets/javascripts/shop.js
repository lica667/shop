$(function () {
  $(document).trigger('initUserJS');
});

$(document).on('page:load', function() {
  $(document).trigger('initUserJS');
});

$(document).on('initUserJS', function(){

  getCurrency();
  setShopCurrency();
  addToCart();
  getCategories();
  setCurrencyButtons();
  // recalculate();
  // setResizeInput();

});

var $AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

function getCurrency() {
  if (!getCookie('currency')){
    $.ajax( { 
      url: '//freegeoip.net/json/', 
      type: 'POST', 
      dataType: 'jsonp',
      success: function(location) {
        changeGoodCurrency(location.country_code)
      }
    });
  } else {
    setCurrency(getCookie('currency'));
  }
}

// write categories tree
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
    if (value['categories']) {
      $('#'+id).append("<ul id="+value["id"]+"></ul>")
      returnCategoriesTree(value['categories'], value["id"]);
    }
  });
};

function setCurrencyButtons () {
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

function setShopCurrency () {
  $('.cart_price').currency({
    region: "BY",
    thousands: " ",
    decimals: 0
  });
}

$(document).on('initCartTotal', function(){
  setShopCurrency();
});



function addToCart(){
  $('#add_to_cart').on('click', function(){
    var quantity = $(this.parentNode).find('input').val()
    var id = $('.product-info').attr('id')
    data = { 'good_id' : id, 'quantity': quantity, 'authenticity_token': $AUTH_TOKEN }
    $.post('/add_to_cart', data, function(data){
      $('span.cart_total')
        .animate({"backgroundColor": "#4DEC97"}, 400)
        .text(data['cart_total']);
      $(document).trigger('initCartTotal');
      $('span.cart_total').animate({"backgroundColor": " #4DC7EC"}, 400);
    })
  });
}

function getCookie(name) {
  var matches = document.cookie.match(new RegExp(
    "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
  ));
  return matches ? decodeURIComponent(matches[1]) : undefined;
}

function recalculate (argument) {
  $('#recalculate').on('click', function () {
    var data = []
    var form = $('form.cart-info');
    $(form).find('tr.product').each(function() {
      json = {'cart_item':{
                'id': $(this).attr('id'), 
                'quantity': $(this).find('#quantity').val()
                }
              };
      data.push(json);
    })
     $.ajax({
      type: 'PATCH',
      dataType: 'json',
      url:  '/cart/recalculate',
      data: {'authenticity_token': $AUTH_TOKEN, 'data': data}
    });
  });
}

function setResizeInput(){
  function resizeInput() {
    debugger;
      $(this).attr('size', $(this).val().length);
  }

  $('.input_quantity')
      // event handler
      .keyup(resizeInput)
      // resize on page load
      .each(resizeInput);
}
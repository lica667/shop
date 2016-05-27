$(function () {

  getCurrencies();
  setCurrencies();
  getCategories();
  setSlides();
  setCurrencyButtons();
  addToCart();
  
});

$(document).on('page:load', function(){
  getCurrencies();
  setCurrencies();
  getCategories();
  setSlides();
  setCurrencyButtons();
  addToCart();

})

var $currency_eur_to_usd
var $currency_usd_to_byr

function getCurrencies () {
  if ( $( "#currency_eur_to_usd" ).length != 0 ) {
    $.getJSON('/admin.json?token=get_currencies', function(json){
      $currency_eur_to_usd = json['currency_eur_to_usd']
      $currency_usd_to_byr = json['currency_usd_to_byr']
      $( "#currency_eur_to_usd" ).val(json['currency_eur_to_usd']);
      $( "#currency_usd_to_byr" ).val(json['currency_usd_to_byr']);
    });
  }
};

function setCurrencies () {
  if ( $( "#currency_eur_to_usd" ).length ) {
    $( "#currency_eur_to_usd" ).focusout(function(){ setCurrenciesJSON(); });
    $( "#currency_usd_to_byr" ).focusout(function(){ setCurrenciesJSON(); });
  }
};

function setCurrenciesJSON(){
  if ( $( "#currency_eur_to_usd" ).length != 0 ) {
    if ( ($currency_eur_to_usd != $( "#currency_eur_to_usd" ).val()) || ($currency_usd_to_byr != $( "#currency_usd_to_byr" ).val()) )
    $.getJSON('/admin.json?token=set_currencies&eur_to_usd='+
      $( "#currency_eur_to_usd" ).val()+
      '&usd_to_byr='+
      $( "#currency_usd_to_byr" ).val(), function(json){
        $currency_eur_to_usd = $( "#currency_eur_to_usd" ).val();
        $currency_usd_to_byr = $( "#currency_usd_to_byr" ).val();
        $('#updated_currencies').fadeToggle().delay(1000).fadeToggle();
    });  
  }
};
$(document).on('page:load', function() {
  
  getCurrencies();

});

$(window).load(function(){

  getCurrencies();
  
});

function getCurrencies () {
  if ( $( "#currency_eur_to_usd" ).length ) {
    $.getJSON('/admin.json?token=currencies', function(json){
      $( "#currency_eur_to_usd" ).val(json['currency_eur_to_usd']);
      $( "#currency_usd_to_byr" ).val(json['currency_usd_to_byr']);
    });
  }
}
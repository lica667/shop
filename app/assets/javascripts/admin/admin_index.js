var $currency_eur_to_usd
var $currency_usd_to_byn

// get currency values from server
function getCurrencies () {
  if ( $( "#currency_eur_to_usd" ).length != 0 ) {
    $.getJSON('/admin.json?token=get_currencies', function(json){
      $currency_eur_to_usd = json['currency_eur_to_usd']
      $currency_usd_to_byn = json['currency_usd_to_byn']
      $( "#currency_eur_to_usd" ).val(json['currency_eur_to_usd']);
      $( "#currency_usd_to_byn" ).val(json['currency_usd_to_byn']);
    });
  }
};

// set currency values to server
function setCurrencies () {
  if ( $( "#currency_eur_to_usd" ).length ) {
    $( "#currency_eur_to_usd" ).focusout(function(){ setCurrenciesJSON(); });
    $( "#currency_usd_to_byn" ).focusout(function(){ setCurrenciesJSON(); });
  }
};

function setCurrenciesJSON(){
  if ( $( "#currency_eur_to_usd" ).length != 0 ) {
    if ( ($currency_eur_to_usd != $( "#currency_eur_to_usd" ).val()) || ($currency_usd_to_byn != $( "#currency_usd_to_byn" ).val()) )
    $.getJSON('/admin.json?token=set_currencies&eur_to_usd='+
      $( "#currency_eur_to_usd" ).val()+
      '&usd_to_byn='+
      $( "#currency_usd_to_byn" ).val(), function(json){
        $currency_eur_to_usd = $( "#currency_eur_to_usd" ).val();
        $currency_usd_to_byn = $( "#currency_usd_to_byn" ).val();
        $('#updated_currencies').fadeToggle().delay(1000).fadeToggle();
    });  
  }
};
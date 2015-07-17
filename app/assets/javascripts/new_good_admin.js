$(document).on('page:load', function() {

  // getCategoriesInput();
  activateCurrencyRate();

});

$(window).load(function(){

  // getCategoriesInput();  
  activateCurrencyRate();
  
});

var $good_cost_usd
var $good_cost_eur
var $good_cost_byr

function activateCurrencyRate () {
  
  if ($('good_cost_usd').length != 0) {
    $good_cost_usd = $('#good_cost_usd').val();
    $good_cost_eur = $('#good_cost_eur').val();
    $good_cost_byr = $('#good_cost_byr').val();
  };

};

function getCategoriesInput(){

  if ($('h2').text() == "New good"){
    $.getJSON('/categories.json', function(json){

      $('#input_categories').children().remove();
      returnCategoriesTreeInput(json['categories'], 'input_categories');

    });
  };

};

function returnCategoriesTreeInput(categories, id){
  $.each( categories , function(index, value){
    appendElement(id, value);
    console.log('id:' +id+ ' |name: ' + value['name']);
  });
}

function appendElement(id, value){

  $('#'+id).append("<div class='checkbox'><label class='choice' for='good_category_ids_"+value['id']+"'><input id='good_category_ids_"+value['id']+"' name='good[category_ids][]' type='checkbox' value='"+value['id']+"'>"+value['name']+"</input>"+"</label></div>")
  if (value['categories']) {
    $('#'+id).append("<div id="+value["id"]+"></div>")
    returnCategoriesTreeInput(value['categories'], value["id"]);
  }

}
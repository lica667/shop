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
  
  if ($('#good_cost_usd').length != 0) {
    $good_cost_usd = $('#good_cost_usd').val();
    $good_cost_eur = $('#good_cost_eur').val();
    $good_cost_byr = $('#good_cost_byr').val();

    $('#good_cost_usd').change(function(){
      $good_cost_usd = $('#good_cost_usd').val();
      $good_cost_eur = $('#good_cost_eur').val();
      $good_cost_byr = $('#good_cost_byr').val();
      $.getJSON('/admin/update_costs.json?token=usd&value='+$(this).val()+'', function(json){

        $('#good_cost_eur').val(json['eur']);
        $('#good_cost_byr').val(json['byr']);

      });
      undoAutoPasteCosts();
    })

    $('#good_cost_eur').change(function(){
      $good_cost_usd = $('#good_cost_usd').val();
      $good_cost_eur = $('#good_cost_eur').val();
      $good_cost_byr = $('#good_cost_byr').val();
      $.getJSON('/admin/update_costs.json?token=eur&value='+$(this).val()+'', function(json){

        $('#good_cost_usd').val(json['usd']);
        $('#good_cost_byr').val(json['byr']);

      });
      undoAutoPasteCosts();
    })

    $('#good_cost_byr').change(function(){
      $good_cost_usd = $('#good_cost_usd').val();
      $good_cost_eur = $('#good_cost_eur').val();
      $good_cost_byr = $('#good_cost_byr').val();
      $.getJSON('/admin/update_costs.json?token=byr&value='+$(this).val()+'', function(json){

        $('#good_cost_eur').val(json['eur']);
        $('#good_cost_usd').val(json['usd']);

      });
      undoAutoPasteCosts();
    })
  };

};

function undoAutoPasteCosts (argument) {
  $('#undo_auto_paste_costs').click(function() {
    $('#good_cost_usd').val($good_cost_usd);
    $('#good_cost_eur').val($good_cost_eur);
    $('#good_cost_byr').val($good_cost_byr);
  });
  console.log('usd ' + $('#good_cost_usd').val() + ' ' + $good_cost_usd);
  console.log('eur ' + $('#good_cost_eur').val() + ' ' + $good_cost_eur);
  console.log('byr ' + $('#good_cost_byr').val() + ' ' + $good_cost_byr);
}

function AutoInsertCosts (body) {
  console.log(body);
}

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
var $good_cost_usd
var $good_cost_eur
var $good_cost_byn
var $photo_count = 1

// change costs with all currencies
function activateCurrencyRate () {
  
  if ($('#good_cost_usd').length != 0) {
    $good_cost_usd = $('#good_cost_usd').val();
    $good_cost_eur = $('#good_cost_eur').val();
    $good_cost_byn = $('#good_cost_byn').val();

    $('#good_cost_usd').change(function(){
      $good_cost_usd = $('#good_cost_usd').val();
      $good_cost_eur = $('#good_cost_eur').val();
      $good_cost_byn = $('#good_cost_byn').val();
      $.getJSON('/admin/update_costs.json?token=usd&value='+$(this).val()+'', function(json){

        $('#good_cost_eur').val(json['eur']);
        $('#good_cost_byn').val(json['byn']);

      });
      undoAutoPasteCosts();
    })

    $('#good_cost_eur').change(function(){
      $good_cost_usd = $('#good_cost_usd').val();
      $good_cost_eur = $('#good_cost_eur').val();
      $good_cost_byn = $('#good_cost_byn').val();
      $.getJSON('/admin/update_costs.json?token=eur&value='+$(this).val()+'', function(json){

        $('#good_cost_usd').val(json['usd']);
        $('#good_cost_byn').val(json['byn']);

      });
      undoAutoPasteCosts();
    })

    $('#good_cost_byn').change(function(){
      $good_cost_usd = $('#good_cost_usd').val();
      $good_cost_eur = $('#good_cost_eur').val();
      $good_cost_byn = $('#good_cost_byn').val();
      $.getJSON('/admin/update_costs.json?token=byn&value='+$(this).val()+'', function(json){

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
    $('#good_cost_byn').val($good_cost_byn);
  });
}

// function is not finished yet...maybe
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

function AddOrRemovePhotoFields() {

  if ( $('#add_photo').length != 0){
    $('#add_photo').click(function() {
      $('.photo_fields').last().after("<div class='nested-fields photo_fields'>"+
        "<a class='remove_photo'> <i class='icon-remove'/></a>"+
        "<fieldset class='inputs'>"+
          "<div class='file input optional form-group' id='good_photos_attributes_"+$photo_count+"_avatar_input'>"+
            "<span class='form-wrapper'>"+
              "<input id='good_photos_attributes_"+$photo_count+"_avatar' name='good[photos_attributes]["+$photo_count+"][avatar]' type='file' />"+
            "</span>"+
          "</div>"+
          "<div class='string input optional stringish form-group' id='good_photos_attributes_"+$photo_count+"_description_input'>"+
            "<span class='form-label'>"+
              "<label class='control-label' for='good_photos_attributes_"+$photo_count+"_description'>Description</label>"+
            "</span>"+
            "<span class='form-wrapper'>"+
              "<input class='form-control' id='good_photos_attributes_"+$photo_count+"_description' maxlength='255' name='good[photos_attributes]["+$photo_count+"][description]' type='text' />"+
            "</span>"+
          "</div>"+
        "</fieldset>"+
      "</div>")
      $photo_count++;
    });
  }
  if ( $('.remove_photo').length != 0){
    $('body').on('click', '.remove_photo', (function(event) {
      // $photo_count--;
      $(this).parent().remove();
    }));
  }

}
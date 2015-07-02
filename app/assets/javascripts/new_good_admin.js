$(document).on('page:load', function() {
  // if ($('h2').text('New good')){
    // getCategoriesInput();
  // };

});

$(window).load(function(){

  // if ($('h2').text('New good')){
    // getCategoriesInput();  
  // };
  
});

function getCategoriesInput(){


  $.getJSON('/categories.json', function(json){
    console.log("JSON2");
    console.log(json);

    // console.log(returnCategoriesTreeInput(json));
    $('#input_categories').children().remove();
    returnCategoriesTreeInput(json['categories'], 'input_categories');
  });


};

function returnCategoriesTreeInput(categories, id){
  $.each( categories , function(index, value){
    // $('#'+id).append("<li><a href = '/category?id="+value['id']+"'>" + value["name"] + "</a></li>")
    // // console.log('id:' +id+ ' |name: ' + value["name"]);
    // if (value['categories']) {
    //   $('#'+id).append("<ul id="+value["id"]+"></ul>")
    //   returnCategoriesTree(value['categories'], value["id"]);
    // }
    appendElement(id, value);
    console.log('id:' +id+ ' |name: ' + value['name']);
  });
}

function appendElement(id, value){

  $('#'+id).append("<div class='checkbox'><label class='choice' for='good_category_ids_"+value['id']+"'><input id='good_category_ids_"+value['id']+"' name='good[category_ids][]' type='checkbox' value='"+value['id']+"'>"+value['name']+"</input>"+"</label></div>")
  // console.log('id:' +id+ ' |name: ' + value);
  if (value['categories']) {
    $('#'+id).append("<div id="+value["id"]+"></div>")
    returnCategoriesTreeInput(value['categories'], value["id"]);
  }

}
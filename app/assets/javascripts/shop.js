// $(function() {
//   $('.categories').jstree({
//    'core': {
//      'data':getCategories();
//    }
//   });
// });

$(document).on('page:load', function() {

  getCategories();

});

$(window).load(function(){

  getCategories();
  
});

function getCategories(){


  $.getJSON('/admin/categories.json', function(json){

    // console.log(returnCategoriesTree(json));
    returnCategoriesTree(json['categories'], 'categories');
  });


};

function returnCategoriesTree(categories, id){
  // path = path || '|';
  // el = $('#'+id);
  // console.log(id);

  if (Array.isArray(categories)){
    $.each( categories , function(index, value){
      $('#'+id).append("<li><a href = '/category?id="+value['id']+"'>" + value["name"] + "</a></li>")
      console.log('id:' +id+ ' |name: ' + value["name"]);
      if (value['categories']) {
        $('#'+id).append("<ul id="+value["id"]+"></ul>")
        returnCategoriesTree(value['categories'], value["id"]);
      }
    });
  } else {
    $('#'+id).append("<li><a href = '/category?id="+value['id']+"'>" + value["name"] + "</a></li>")
      console.log('id:' +id+ ' |name: ' + value["name"]);
    if (value['categories']) {
      $('#'+id).append("<ul id="+value["id"]+"></ul>")
      returnCategoriesTree(value['categories'], value["id"]);
    }
  }
  // return categories['categories']
};
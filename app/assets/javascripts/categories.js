$(document).on('page:load', function() {
  
  getCategories();
});

$(window).load(function(){

  getCategories();
  
});

function getCategories(){


  $.getJSON('/admin/categories.json', function(json){

    // console.log(returnCategoriesTree(json));
    returnCategoriesTree(json);
  });


};

function returnCategoriesTree(categories, path){
  path = path || '|';
  console.log(categories["categories"].length);
  // if (categories["categories"].length > 0) {
  //   $.each( categories["categories"], function(index, value){
  //     console.log( path + ' ' + value["name"] );
  //   });
  // };
}
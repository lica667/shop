// $(function() {
//   $('.categories').jstree({
//    'core': {
//      'data':getCategories();
//    }
//   });
// });

// $(document).on('page:load', function() {

//   getCategories();
//   setSlides();
//   setGoodCost();

// });

// $(window).load(function(){

//   getCategories();
//   setSlides();
//   setGoodCost();
  
// });

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
    // console.log('id:' +id+ ' |name: ' + value["name"]);
    if (value['categories']) {
      $('#'+id).append("<ul id="+value["id"]+"></ul>")
      returnCategoriesTree(value['categories'], value["id"]);
    }
  });
};

function setGoodCost () {
  $('.good_price').currency({
    region: "USD"
  });
}
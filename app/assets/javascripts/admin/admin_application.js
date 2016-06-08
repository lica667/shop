//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

$(function () {
  $(document).trigger('initAdminJS');
});

$(document).on('page:load', function() {
  $(document).trigger('initAdminJS');
});

$(document).on('initAdminJS', function(){

  // getCategoriesInput();
  activateCurrencyRate();
  AddOrRemovePhotoFields();
  getCurrencies();
  setCurrencies();

});

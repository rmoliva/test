// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.

// Rating Page management closure
// TODO: Localize with I18n-js
var RatingPage = function(config) {
  var default_opts = {
    rating_items_el: '.rating_item',
  };

  var options = R.merge(default_opts, config);
  var services = ProductServices();

  var initialize = function() {
    _attachEvents();
  };

  var _attachEvents = function() {
    $(options.rating_items_el).on('click', _setProductRating);
  };

  var _detachEvents = function() {
    $(options.rating_items_el).off('click', _setProductRating);
  };

  var _setProductRating = function(e) {
    var element = $(e.currentTarget);

    _rateProduct(
      element.data('id'),
      element.data('rating'),
    ).then(function() {
      var dropdown = element.closest('.dropdown');
      // Put the chosen rating on the dropdown
      dropdown.find('.rating_value').html(element.data('rating'))
    });
  };

  var _rateProduct = function(product_id, rating) {
    return services.update(
      product_id, {
        rating: rating,
      },
    );
  };

  return {
    initialize: initialize,
  };
};
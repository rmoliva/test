// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.

// Product Page management closure
// TODO: Localize with I18n-js
var ProductsPage = function(config) {
  var default_opts = {
    page: 1,
    order: 'name',
    rating: null,
    per_page: 10,
    add_product_el: '#add_product',
    products_table_el: '#products_table',
    product_modal: '#product_modal',
    product_modal_cancel: '#product_modal_cancel',
    product_modal_confirm: '#product_modal_confirm',
    product_records_info: '#product_records_info',
    product_form: {
      name_el: '#product_name',
      price_el: '#product_price',
      rating_el: '#product_rating'
    },
    product_page_prev: '#product_page_prev',
    product_page_next: '#product_page_next',
    product_rating_filter: '#product_rating_filter',
  };

  var options = R.merge(default_opts, config);
  var services = ProductServices();

  var initialize = function() {
    _attachEvents();

    // Load initial product list
    _reloadProducts();
  };

  var _attachEvents = function() {
    $(options.product_page_prev).on('click', _prevPage);
    $(options.product_page_next).on('click', _nextPage);
    $(options.add_product_el).on('click', _newProduct);
    $('.product_edit').on('click', _editProduct);
    $('.product_delete').on('click', _deleteProduct);
    $(options.product_rating_filter).find('.filter_item').on('click', _selectRatingFilter);
  };

  var _detachEvents = function() {
    $(options.product_page_prev).off('click', _prevPage);
    $(options.product_page_next).off('click', _nextPage);
    $(options.add_product_el).off('click', _newProduct);
    $('.product_edit').off('click', _editProduct);
    $('.product_delete').off('click', _deleteProduct);
    $(options.product_rating_filter).find('.filter_item').off('click', _selectRatingFilter);
  };

  var _prevPage = function() {
    if (options.page === 1) {
      return;
    }
    options.page -= 1;
    _reloadProducts();
  }

  var _nextPage = function() {
    // TODO: Control maximun pages
    options.page += 1;
    _reloadProducts();
  };

  var _selectRatingFilter = function(e) {
    var element = $(e.currentTarget);
    options.rating = element.data('rating');
    options.page = 1;
    _reloadProducts();
  };

  var _newProduct = function() {
    _setModalTitle('Nuevo Producto');
    _resetFormData();
    _showModal();
    _disableFormData(false);
    return _waitForModalButton().then(function(confirm) {
      // Save product record
      var form_data = _getFormData();

      return services.create(
        form_data
      ).then(function(){
        // TODO: Show a message with the result (error or succeed)
        return _reloadProducts();
      });
    });
  };

  var _editProduct = function(e) {
    var element = $(e.currentTarget),
      id = element.data('id');
    _setModalTitle('Modificar Producto');
    _showModal();
    // Load the product data
    return services.show(id).then(function(product_date) {
      _disableFormData(false);
      _setFromData(product_date)
    }).then(function() {
      // Show modal and wait for confirmation
      return _waitForModalButton().then(function(confirm) {
        if (!confirm) {
          return;
        }

        // Save product record
        var form_data = _getFormData();

        return services.update(
          id,
          form_data
        ).then(function(){
          // TODO: Show a message with the result (error or succeed)
          return _reloadProducts();
        });
      });
    });
  };

  var _deleteProduct = function(e) {
    var element = $(e.currentTarget),
      id = element.data('id');
    _setModalTitle('Borrar Producto');
    _showModal();
    // Load the product data
    return services.show(id).then(function(product_date) {
      _setFromData(product_date)
      _disableFormData(true);
    }).then(function() {
      // Show modal and wait for confirmation
      return _waitForModalButton().then(function(confirm) {
        if (!confirm) {
          return;
        }

        // Save product record
        var form_data = _getFormData();

        return services.destroy(id).then(function(){
          // TODO: Show a message with the result (error or succeed)
          return _reloadProducts();
        });
      });
    });
  };

  var _reloadProducts = function() {
    _detachEvents();
    return services.index({
      page: options.page,
      per_page: options.per_page,
      order: options.order,
      rating: options.rating,
    }).then(function(server_data) {
      _renderTableBody(server_data.records);
      _showRecords(server_data.total_count);
      _attachEvents();
    });
  };

  var _setModalTitle = function(title) {
    var el = $(options.product_modal).find('.modal-title');
    el.html(title);
  };

  var _renderTableBody = function(products) {
    var $body = $(options.products_table_el).find('tbody');
    var lines = R.map(_rowHtml, products);

    // First clear the products table
    $body.empty();

    // Append lines to table body
    R.forEach(function(line) {
      $body.append(line);
    }, lines);
  };

  var _showRecords = function(total_count) {
    var from = 1 + (options.page - 1) * options.per_page,
      to = from + options.per_page;
    if (to > total_count) {
      to = total_count;
    }

    $(options.product_records_info).html(
      "Mostrando: " + from + " a " + to + " de " + total_count + " productos"
    );
  };

  var _rowHtml = function(product) {
    // TODO: This is better done with a template engine
    var html = "<tr>";
    html += "<td><a class='product_edit' data-id=" + product.id + "><i class='glyphicon glyphicon-pencil'></i></a></td>";
    html += "<td><a class='product_delete' data-id=" + product.id + "><i class='glyphicon glyphicon-trash'></i></a></td>";
    html += "<td>" + product.name + "</td>";
    html += "<td>" + product.price + "</td>";
    html += "<td>" + product.rating + "</td>";
    html += "</tr>";
    return html;
  };

  var _disableFormData = function(disable) {
    $(options.product_form.name_el).prop("disabled", disable);
    $(options.product_form.price_el).prop("disabled", disable);
    $(options.product_form.rating_el).prop("disabled", disable);
  };

  var _getFormData = function() {
    return {
      name: $(options.product_form.name_el).val(),
      price: $(options.product_form.price_el).val(),
      rating: $(options.product_form.rating_el).val(),
    };
  };

  // The next function validates the form and shows and alert box if is not
  // valid. Also returns true if form data is ok or false if it isnt
  var _alertIfInvalidForm = function() {
    if (_isValidateForm()) {
      return true;
    }

    // TODO: Improve validation information
    alert('Los datos introducidos son incorrectos');
    return false;
  };

  var _isValidateForm = function() {
    var form_data = _getFormData();
    if (
      R.isEmpty(form_data.name) ||
      R.isEmpty(form_data.price) ||
      R.isEmpty(form_data.rating)
    ) {
      return false;
    }
    return true;
  };

  var _showModal = function() {
    $(options.product_modal).modal({
      backdrop: 'static',
      keyboard: false,
    });
  };

  var _closeModal = function() {
    $(options.product_modal).modal('hide');
  };

  var _resetFormData = function(product_data) {
    _setFromData({
      name: '',
      price: 0,
      rating: 0,
    });
  };

  var _setFromData = function(product_data) {
    $(options.product_form.name_el).val(product_data.name);
    $(options.product_form.price_el).val(product_data.price);
    $(options.product_form.rating_el).val(product_data.rating);
  };

  var _waitForModalButton = function() {
    var cancel_el = $(options.product_modal_cancel);
    var confirm_el = $(options.product_modal_confirm);

    return new Promise(function(resolve, reject) {
      var _subscribeFns = function() {
        $(cancel_el).on('click', _cancelFn);
        $(confirm_el).on('click', _confirmFn);
      };
      var _unsubscribeFns = function() {
        $(cancel_el).off('click', _cancelFn);
        $(confirm_el).off('click', _confirmFn);
      };

      var _cancelFn = function() {
        _unsubscribeFns();
        _closeModal();
        resolve(false);
      };
      var _confirmFn = function() {
        // Check if data is correct
        if (!_alertIfInvalidForm()) {
          return;
        }
        _unsubscribeFns();
        _closeModal();
        resolve(true);
      };

      _subscribeFns();
    });
  };

  return {
    initialize: initialize,
  };
};
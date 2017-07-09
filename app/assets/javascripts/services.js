

var ProductServices = function() {
  amplify.request.define("productsIndex", "ajax", {
    url: "/products.json",
    type: "GET",
    decoder: _decoder
  });

  amplify.request.define("productsCreate", "ajax", {
    url: "/products.json",
    type: "POST",
    decoder: _decoder
  });

  amplify.request.define("productsUpdate", "ajax", {
    url: "/products/{product_id}.json",
    type: "PUT",
    decoder: _decoder
  });

  amplify.request.define("productsShow", "ajax", {
    url: "/products/{product_id}.json",
    type: "GET",
    decoder: _decoder
  });

  amplify.request.define("productsDestroy", "ajax", {
    url: "/products/{product_id}.json",
    type: "DELETE",
    decoder: _decoder
  });

  var index = function(options) {
    return _promiseRequest("productsIndex", {
      page: options.page,
      order: options.order,
      per_page: options.per_page,
      'q[rating_eq]': options.rating,
    });
  };

  var create = function(record) {
    return _promiseRequest("productsCreate", {
      product: record,
    });
  };

  var update = function(product_id, record) {
    return _promiseRequest("productsUpdate", {
      product_id: product_id,
      product: record,
    });
  };

  var show = function(product_id) {
    return _promiseRequest("productsShow", {
      product_id: product_id,
    });
  };

  var destroy = function(product_id) {
    return _promiseRequest("productsDestroy", {
      product_id: product_id,
    });
  };

  var _promiseRequest = function(resourceId, data) {
    return new Promise(function(resolve, reject) {
      amplify.request({
        resourceId: resourceId,
        data: data,
        success: function(data) {
          if(data.success) {
            resolve(data.data);
          } else {
            reject(data.message);
          }
        },
        error: reject
      });
    });
  };

  /**
   * Trata los valores devueltos por los reiqests
   * @data <Object> Datos devueltos por el request
   * @status <String> Indica si el resultado del request ha sido satisfactorio o no
   * @xhr
   * @success <Function> Función a ejecutar cuando se produce success en el request
   * @error <Function> Función a ejecutar cuando se produce un error en el request
   */
  var _decoder = function(data, status, xhr, success, error) {
    if (status === "success") {
      success(data, status);
    } else if (status === "fail" || status === "error") {
      error(xhr.responseText, status);
    }
  };

  return {
    index: index,
    show: show,
    create: create,
    update: update,
    destroy: destroy,
  };
};
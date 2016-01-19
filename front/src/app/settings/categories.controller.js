(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('CategoriesController', CategoriesController);

    function CategoriesController(IndexFactory) {
      var vm = this;

      IndexFactory.getCategories().then(function(res) {
        vm.categories = res.categories;
      });
    }

})();

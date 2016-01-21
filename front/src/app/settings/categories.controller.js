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

      vm.sortable = {
        stop: function() {
          vm.category_range = [];
          var key;
          for (key in vm.categories) {
            vm.category_range.push(vm.categories[key].id);
          }
          IndexFactory.postCategoryRange(vm.category_range).then(function() {
          });
        },
        axis: ''
      };
    }

})();

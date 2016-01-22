(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('CategoriesController', CategoriesController);

    function CategoriesController(IndexFactory) {
      var vm = this;

      vm.add_field = false;

      IndexFactory.getCategories().then(function(res) {
        vm.categories = res.categories;
      });

      vm.sortable = {
        update: function(e, ui) {
          if (!ui.item.sortable.model) {
            ui.item.sortable.cancel();
          } else {
            vm.category_range = [];
            var key;
            for (key in vm.categories) {
              vm.category_range.push(vm.categories[key].id);
            }
            IndexFactory.postCategoryRange({sequence: vm.category_range}).then(function() {
            });
          }
        },
        axis: ''
      };

      vm.addNewPanel = function() {
        vm.add_field = true;
      };

      vm.createCategory = function(e) {
        if (e.which === 13) {
          IndexFactory.postCategory({name: vm.new_category_name}).then(function() {
            IndexFactory.getCategories().then(function(res) {
              vm.categories = res.categories;
            });
            vm.new_category_name = '';
            vm.add_field = false;
          });
        }
      };
    }

})();

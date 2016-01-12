(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('EditPasswordController', EditPasswordController);

    function EditPasswordController(IndexFactory) {
      var vm = this;

      vm.submit = function() {
      }
      vm.clearErrors = function() {
        vm.errors = '';
      }
    }
})();

(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('EditPasswordController', EditPasswordController);

    function EditPasswordController(IndexFactory, $location) {
      var vm = this;

      vm.email = $location.search()['email'];

      vm.submit = function() {
      }
      vm.clearErrors = function() {
        vm.errors = '';
      }
    }
})();

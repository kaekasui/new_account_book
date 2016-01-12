(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('EditPasswordController', EditPasswordController);

    function EditPasswordController(IndexFactory) {
      var vm = this;

      vm.submit = function() {
        vm.errors = {'error_messages': 'aaaa'};
      }
      vm.clearErrors = function() {
        vm.errors = '';
      }
    }
})();

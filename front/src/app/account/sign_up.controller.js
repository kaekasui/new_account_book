(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('SignUpController', SignUpController);

    function SignUpController($http, $location, menuService, IndexFactory) {
      var vm = this;

      vm.menus = menuService.getMenu();
      vm.clearErrors = function() {
        vm.errors = '';
      }
      vm.submit = function() {
        var params = {
          email: vm.email,
          password: vm.password,
          password_confirmation: vm.password_confirmation
        };

        IndexFactory.postEmailUserRegistrations(params).catch(function(res) {
          vm.errors = res.error_messages;
        });
      }
    }
})();

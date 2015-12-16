(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('SignUpController', SignUpController);

    function SignUpController($http, $location, menuService) {
      var vm = this;

      vm.menus = menuService.getMenu();
      vm.submit = function() {
        var params = {
          email: vm.email,
          password: vm.password,
          password_confirmation: vm.password_confirmation
        };
        $http.post('http://localhost:3001/email_user/registrations', params)
          .success(function(data, status, headers, config) {
            $location.path('/');
          })
          .error(function(data, status, headers, config) {
            if (typeof data != 'undefined') {
              vm.errors = data.error_messages;
            }
          })
        }
      }
})();

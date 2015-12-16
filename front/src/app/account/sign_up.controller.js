(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('SignUpController', SignUpController);

    function SignUpController($http, menuService) {
      var vm = this;

      vm.menus = menuService.getMenu();
      vm.submit = function() {
        var params = {
          email: 'email@a.com',
          password: 'password'
        };
        $http.post('/email_user/registrations', params)
          .success(function(data, status, headers, config) {
            vm.title = status;
          })
          .error(function(data, status, headers, config) {
            vm.title = status;
          })
        }
      }
})();

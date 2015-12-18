(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('LoginController', LoginController);

    function LoginController(menuService, IndexFactory) {
      var vm = this;

      vm.menus = menuService.getMenu();
      vm.submit = function() {
        var params = {
          email: vm.email,
          password: vm.password
        };

        IndexFactory.postSession(params).then(function(res) {
        }).catch(function(res) {
          vm.errors = res.error_messages;
        });
      }
    }

})();

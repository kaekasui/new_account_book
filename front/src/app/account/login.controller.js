(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('LoginController', LoginController);

    function LoginController(menuService) {
      var vm = this;

      vm.menus = menuService.getMenu();
    }

})();

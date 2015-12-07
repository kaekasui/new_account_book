(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('SignUpController', SignUpController);

    function SignUpController(menuService) {
      var vm = this;

      vm.menus = menuService.getMenu();
    }

})();

(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('ResetPasswordController', ResetPasswordController);

    function ResetPasswordController(menuService) {
      var vm = this;

      vm.menus = menuService.getMenu();
    }

})();

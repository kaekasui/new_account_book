(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('ResendEmailController', ResendEmailController);

    function ResendEmailController(menuService) {
      var vm = this;

      vm.menus = menuService.getMenu();
    }

})();

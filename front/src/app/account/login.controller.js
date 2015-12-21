(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('LoginController', LoginController);

    function LoginController(menuService, IndexFactory, toastr, $translate) {
      var vm = this;

      vm.menus = menuService.getMenu();
      vm.submit = function() {
        var params = {
          email: vm.email,
          password: vm.password
        };

        IndexFactory.postSession(params).then(function(res) {
          toastr.success($translate.instant('MESSAGES.LOGIN'));
        }).catch(function(res) {
          vm.errors = res.error_messages;
        });
      }
      vm.clearErrors = function() {
        vm.errors = '';
      }
    }

})();

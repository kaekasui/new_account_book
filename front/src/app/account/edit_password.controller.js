(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('EditPasswordController', EditPasswordController);

    function EditPasswordController(IndexFactory, $location) {
      var vm = this;

      vm.user_id = $location.search()['user_id'];
      vm.email = $location.search()['email'];
      vm.token = $location.search()['token'];

      vm.submit = function() {
        var params = {
          current_password: vm.current_password,
          password: vm.password,
          password_confirmation: vm.password_confirmation,
          token: vm.token,
        };

        IndexFactory.patchNewPassword(vm.user_id, params).catch(function(res) {
          if (res.error_messages == 'Not Found') {
            vm.errors = [$translate.instant('MESSAGES.NOT_FOUND_EMAIL')];
          } else {
            vm.errors = res.error_messages;
          }
        });
      }

      vm.clearErrors = function() {
        vm.errors = '';
      }
    }
})();

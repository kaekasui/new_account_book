(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('ResetPasswordController', ResetPasswordController);

    function ResetPasswordController(IndexFactory) {
      var vm = this;

      vm.submit = function() {
        var params = {
          email: vm.email
        };

        IndexFactory.postResetPassword(params).catch(function(res) {
          vm.errors = res.error_messages;
        });
      }
    }
})();

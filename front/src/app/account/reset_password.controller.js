(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('ResetPasswordController', ResetPasswordController);

    function ResetPasswordController() {
      var vm = this;

      vm.submit = function() {
        var params = {
          email: vm.email
        };

    //    IndexFactory.postSession(params).catch(function(res) {
    //      vm.errors = res.error_messages;
    //    });
      }
    }

})();

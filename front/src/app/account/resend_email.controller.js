(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('ResendEmailController', ResendEmailController);

    function ResendEmailController(IndexFactory, $translate) {
      var vm = this;

      vm.submit = function() {
        var params = {
          email: vm.email
        };

        IndexFactory.postResendEmail(params).catch(function(res) {
          if (res.error_messages == 'Not Found') {
            vm.errors = [$translate.instant('MESSAGES.NOT_FOUND_EMAIL')];
          } else {
            vm.errors = res.error_messages;
          }
        });
      }
    }
})();

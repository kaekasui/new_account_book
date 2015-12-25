(function() {
  'use strict';

    angular
      .module('accountBook')
      .factory('MenuFactory', MenuFactory);

    function MenuFactory($translate, $filter) {
      return ({
        getMenu: function() {
          return [
            { name: $translate.instant('TITLES.LOGIN'), icon: 'glyphicon-leaf', url: 'login' },
            { name: $filter('translate')('TITLES.LOGIN'), icon: 'glyphicon-leaf', url: 'login' },
            { name: $translate.instant('TITLES.SIGN_UP'), icon: 'glyphicon-heart', url: 'sign_up' },
            { name: $translate.instant('TITLES.RESET_PASSWORD'), icon: 'glyphicon-leaf', url: 'reset_password' },
            { name: $translate.instant('TITLES.RESEND_EMAIL'), icon: 'glyphicon-heart', url: 'resend_email' }
          ]
        }
      });
    }
})();

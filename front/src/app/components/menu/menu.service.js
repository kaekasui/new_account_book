(function() {
  'use strict';

  angular
    .module('accountBook')
    .service('menuService', menuService);

  function menuService($translate) {
    var data = [
      { name: $translate.instant('TITLES.LOGIN'), icon: 'glyphicon-leaf', url: 'login' },
      { name: $translate.instant('TITLES.SIGN_UP'), icon: 'glyphicon-heart', url: 'sign_up' },
      { name: $translate.instant('TITLES.RESET_PASSWORD'), icon: 'glyphicon-leaf', url: 'reset_password' },
      { name: $translate.instant('TITLES.RESEND_EMAIL'), icon: 'glyphicon-heart', url: 'resend_email' }
    ];
    this.getMenu = getMenu;

    function getMenu() {
      return data;
    }
  }
})();

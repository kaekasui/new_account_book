(function() {
  'use strict';

  angular
    .module('accountBook')
    .directive('menuDirective', menuDirective);

  function menuDirective() {
    var directive = {
      restrict: 'C',
      templateUrl: 'app/components/menu/menu.html',
      controller: MenuController,
      controllerAs: 'menu'
    };

    return directive;

    function MenuController($translate) {
      this.menu_names = [
        { name: $translate.instant('TITLES.LOGIN'), icon: 'glyphicon-leaf', url: 'login' },
        { name: $translate.instant('TITLES.SIGN_UP'), icon: 'glyphicon-heart', url: 'sign_up' },
        { name: $translate.instant('TITLES.RESET_PASSWORD'), icon: 'glyphicon-leaf', url: 'reset_password' },
        { name: $translate.instant('TITLES.RESEND_EMAIL'), icon: 'glyphicon-heart', url: 'resend_email' }
      ];
      this.menu_image = 'assets/images/pig_footprints.gif';
      this.isSelected = function(index) {
        return this.selected == index;
      };
 
      // Event
      this.mouseEnter = function(index) {
        this.selected = index;
      };
      this.mouseLeave = function() {
        this.selected = undefined;
      };
    }
  }
})();

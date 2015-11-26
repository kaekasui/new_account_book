(function() {
  'use strict';

  angular
    .module('accountBook')
    .directive('menuDirective', menuDirective);

  function menuDirective() {
    var directive = {
      restrict: 'C',
      templateUrl: 'app/components/menu/menu.html',
      controller: MenuController
    };

    return directive;

    function MenuController($scope, $translate) {
      $scope.menus = [
        { name: $translate.instant('TITLES.LOGIN'), icon: 'glyphicon-leaf', url: 'login' },
        { name: $translate.instant('TITLES.SIGN_UP'), icon: 'glyphicon-heart', url: 'sign_up' }
      ];
    }
  }
})();

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

    function MenuController($scope) {
      $scope.menus = [
        { name: 'ログイン', icon: 'glyphicon-leaf', url: 'login' },
        { name: '新規登録', icon: 'glyphicon-heart', url: 'sign_up' }
      ];
    }
  }
})();

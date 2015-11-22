(function() {
  'use strict';

  angular
    .module('accountBook')
    .directive('menuDirective', menuDirective);

  function menuDirective() {
    var directive = {
      restrict: 'C',
      templateUrl: 'app/components/menu/menu.html'
    }

    return directive;
  }

})();

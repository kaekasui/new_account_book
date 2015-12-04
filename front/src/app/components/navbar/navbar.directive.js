(function() {
  'use strict';

  angular
    .module('accountBook')
    .directive('acmeNavbar', acmeNavbar);

  function acmeNavbar() {
    var directive = {
      restrict: 'E',
      templateUrl: 'app/components/navbar/navbar.html',
      scope: {
          creationDate: '='
      },
      controller: NavbarController,
      controllerAs: 'vm',
      bindToController: true
    };

    return directive;

    function NavbarController() {
    }
  }

})();

(function() {
  'use strict';

  angular
    .module('accountBook')
    .directive('acmeNavbar', acmeNavbar);

  function acmeNavbar(IndexFactory, localStorageService, $location) {
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

    function NavbarController(IndexFactory, localStorageService, $location) {
      var vm = this;
      vm.current_user = IndexFactory.currentUser();
      //vm.$watch('current_user', function() {
      //});
      vm.logout = function() {
        localStorageService.remove('access_token');
        $location.path('/');
      };
    }
  }

})();

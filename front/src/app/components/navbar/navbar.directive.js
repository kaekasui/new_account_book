(function() {
  'use strict';

  angular
    .module('accountBook')
    .controller('NavbarController', NavbarController)
    .directive('acmeNavbar', acmeNavbar);

  function acmeNavbar() {
    var directive = {
      restrict: 'E',
      templateUrl: 'app/components/navbar/navbar.html',
      require: '^acmeNavbar',
      scope: {
          creationDate: '='
      },
      controller: 'NavbarController',
      controllerAs: 'vm',
      bindToController: true
    };

    return directive;
  }

  function NavbarController(IndexFactory, localStorageService, $location, $scope, toastr, $translate) {
    var vm = this;
    $scope.$watch(function() {
      return $location.path();
    }, function() {
      vm.current_user = IndexFactory.currentUser();
    });
    vm.current_user = IndexFactory.currentUser();
    vm.logout = function() {
      localStorageService.remove('access_token');
      vm.current_user = IndexFactory.currentUser();
      toastr.success($translate.instant('MESSAGES.LOGOUT'));
      $location.path('/');
    };
  }

})();

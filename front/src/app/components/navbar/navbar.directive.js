(function() {
  'use strict';

  angular
    .module('accountBook')
    .controller('NavbarController', NavbarController)
    .controller('FeedbackController', FeedbackController)
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

  function NavbarController(IndexFactory, localStorageService, $location, $scope, toastr, $translate, $modal) {
    var vm = this;

    $scope.$watch(function() {
      return $location.path();
    }, function() {
      vm.login_status = IndexFactory.getLoginStatus();
      IndexFactory.getCurrentUser().then(function(res) {
        vm.current_user = res;
      })
    });

    vm.logout = function() {
      localStorageService.remove('access_token');
      vm.login_status = IndexFactory.getLoginStatus();
      toastr.success($translate.instant('MESSAGES.LOGOUT'));
      $location.path('/');
    };

    vm.feedback = function() {
      var modalInstance = $modal.open({
        templateUrl: 'feedback',
        controller: 'FeedbackController',
        controllerAs: 'feedback',
        backdrop: 'static'
      });

      modalInstance.result.then(function () {
        toastr.success($translate.instant('MESSAGES.SEND_MESSAGE'));
      });
    };
  }

  function FeedbackController(IndexFactory, $modalInstance) {
    var vm = this;
    vm.login_status = IndexFactory.getLoginStatus();
    IndexFactory.getCurrentUser().then(function(res) {
      vm.current_user = res;
    })
 
    vm.submit = function() {
      var params;
      if (vm.login_status) {
        params = {
          user_id: vm.current_user.id,
          content: vm.content
        }
      } else {
        params = {
          email: (vm.email == undefined) ? '' : vm.email,
          content: vm.content
        }
      }
 
      IndexFactory.postFeedback(params).then(function(res){
        $modalInstance.close();
      }).catch(function(res) {
        vm.errors = res.error_messages;
      });
    };
  }
})();

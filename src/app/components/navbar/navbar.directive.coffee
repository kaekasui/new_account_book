NavbarController = (IndexFactory, $location, $scope, $translate, toastr, localStorageService, $modal, IndexService) ->
  'ngInject'
  vm = this

  vm.menuCollapse = false

  $scope.$watch ( ->
    IndexService.current_user
  ), ->
    IndexFactory.getCurrentUser().then((res) ->
      vm.current_user = res
      return
    ).catch (res) ->
      return
    return

  vm.logout = () ->
    localStorageService.remove('access_token')
    IndexService.current_user = undefined
    vm.current_user = IndexService.current_user
    toastr.success($translate.instant('MESSAGES.LOGOUT'))
    $location.path('/login')

  vm.feedback = () ->
    modalInstance = $modal.open(
      templateUrl: 'app/components/navbar/modals/feedback.html'
      controller: 'FeedbackController'
      controllerAs: 'feedback'
      backdrop: 'static'
    )
    modalInstance.result.then () ->
      return

  return

navbarDirective = () ->
  directive =
    restrict: 'E'
    templateUrl: 'app/components/navbar/navbar.html'
    controller: 'NavbarController'
    controllerAs: 'navbar'
    bindToController: true

angular.module 'newAccountBook'
  .controller('NavbarController', NavbarController)
  .directive('navbarDirective', navbarDirective)

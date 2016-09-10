NavbarController = (IndexFactory, $location, $scope, $translate, toastr, localStorageService, $uibModal, IndexService) ->
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

  # メニュー「ログアウト」
  vm.logout = () ->
    localStorageService.remove('access_token')
    IndexService.current_user = undefined
    vm.current_user = IndexService.current_user
    toastr.success($translate.instant('MESSAGES.LOGOUT'))
    $location.path('/login')

  # メニュー「フィードバック」
  vm.feedback = () ->
    modalInstance = $uibModal.open(
      templateUrl: 'app/header/feedback/feedback.html'
      controller: 'FeedbackController'
      controllerAs: 'feedback'
      backdrop: 'static'
    )
    modalInstance.result.then () ->
      return

  return

angular.module 'newAccountBook'
  .controller('NavbarController', NavbarController)

NavbarController = (IndexFactory, $location, $scope, $translate, toastr, localStorageService, $modal, IndexService) ->
  'ngInject'
  vm = this

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
      templateUrl: 'feedback'
      controller: 'FeedbackController'
      controllerAs: 'feedback'
      backdrop: 'static'
    )
    modalInstance.result.then () ->
      return

  return

FeedbackController = (IndexFactory, $translate, $modalInstance, toastr) ->
  'ngInject'
  vm = this
  vm.placeholder = $translate.instant('MESSAGES.FEEDBACK')

  IndexFactory.getCurrentUser().then((res) ->
    vm.current_user = res
    return
  ).catch (res) ->
    return

  vm.submit = () ->
    vm.sending = true
    params = {}
    if vm.current_user != undefined
      params =
        user_id: vm.current_user.id,
        content: vm.content
    else
      params =
        email: if vm.email == undefined then '' else vm.email,
        content: vm.content

    IndexFactory.postFeedback(params).then( ->
      $modalInstance.close()
      vm.sending = false
      return
    ).catch (res) ->
      vm.errors = res.error_messages
      vm.sending = false
      return

  vm.cancel = () ->
    $modalInstance.close()

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
  .controller('FeedbackController', FeedbackController)
  .directive('navbarDirective', navbarDirective)

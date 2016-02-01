NavbarController = (IndexFactory, $location, $scope, $translate, toastr, localStorageService, $modal) ->
  'ngInject'
  vm = this

  $scope.$watch ( ->
    $location.path()
  ), ->
    IndexFactory.getCurrentUser().then((res) ->
      vm.login_status = true
      vm.current_user = res
      return
    ).catch (res) ->
      vm.login_status = false
      return
    return

  vm.logout = () ->
    localStorageService.remove('access_token')
    vm.login_status = false
    toastr.success($translate.instant('MESSAGES.LOGOUT'))
    $location.path '/'

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
    vm.login_status = true
    vm.current_user = res
    return
  ).catch (res) ->
    vm.login_status = false
    return

  vm.submit = () ->
    params = {}
    if vm.login_status
      params =
        user_id: vm.current_user.id,
        content: vm.content
    else
      params =
        email: if vm.email == undefined then '' else vm.email,
        content: vm.content

    IndexFactory.postFeedback(params).then( ->
      $modalInstance.close()
      return
    ).catch (res) ->
      vm.errors = res.error_messages
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

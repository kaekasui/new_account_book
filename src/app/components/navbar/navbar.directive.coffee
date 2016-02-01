NavbarController = (IndexFactory, $location, $scope, $translate, toastr, $state, localStorageService) ->
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

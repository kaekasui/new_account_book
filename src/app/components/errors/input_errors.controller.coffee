InputErrorsController = ($stateParams, $location, toastr, $translate) ->
  'ngInject'
  vm = this
  vm.code = $stateParams.id

  if vm.code == '401'
    $location.path 'login'
    toastr.success $translate.instant('MESSAGES.REQUIRED_LOGIN')

  return

angular.module 'newAccountBook'
  .controller('InputErrorsController', InputErrorsController)

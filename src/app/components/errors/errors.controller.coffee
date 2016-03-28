InputErrorsController = ($stateParams) ->
  'ngInject'
  vm = this

  vm.code = $stateParams.id

  return

angular.module 'newAccountBook'
  .controller('InputErrorsController', InputErrorsController)

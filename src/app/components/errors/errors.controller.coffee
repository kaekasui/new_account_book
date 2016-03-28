InputErrorsController = ($stateParams) ->
  'ngInject'
  vm = this

  console.log $stateParams.id
  vm.code = $stateParams.id

  return

angular.module 'newAccountBook'
  .controller('InputErrorsController', InputErrorsController)

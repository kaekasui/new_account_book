MessageController = ($stateParams, UserFactory) ->
  'ngInject'
  vm = this

  UserFactory.getMessage($stateParams.id).then (res) ->
    vm.message = res

  return

angular.module 'newAccountBook'
  .controller('MessageController', MessageController)

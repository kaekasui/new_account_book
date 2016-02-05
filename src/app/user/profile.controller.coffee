ProfileController = (IndexFactory) ->
  'ngInject'
  vm = this

  IndexFactory.getCurrentUser().then (res) ->
    vm.current_user = res
    return

  return

angular.module 'newAccountBook'
  .controller 'ProfileController', ProfileController

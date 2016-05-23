ErrorMessagesController = ($scope) ->
  'ngInject'
  vm = this

  vm.clearErrors = () ->
    vm.errors = ''

  return

angular.module 'newAccountBook'
  .controller('ErrorMessagesController', ErrorMessagesController)

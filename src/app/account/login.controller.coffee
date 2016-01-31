LoginController = (AccountFactory) ->
  'ngInject'
  vm = this

  vm.clearErrors = () ->
    vm.errors = ''

  vm.submit = () ->
    params = {
      email: vm.email
      password: vm.password
    }
    AccountFactory.postSession(params).catch (res) ->
      vm.errors = res.error_messages
      return

  return

angular.module 'newAccountBook'
  .controller 'LoginController', LoginController

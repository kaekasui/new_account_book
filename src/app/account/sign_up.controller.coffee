SignUpController = (AccountFactory) ->
  'ngInject'
  vm = this
  vm.password = ''
  vm.password_confirmation = ''

  vm.clearErrors = () ->
    vm.errors = ''

  vm.submit = () ->
    vm.sending = true
    params = {
      email: vm.email
      password: vm.password
      password_confirmation: vm.password_confirmation
    }
    AccountFactory.postEmailUserRegistration(params).then((res) ->
      vm.sending = false
    ).catch (res) ->
      vm.errors = res.error_messages
      vm.sending = false
      return

  return

angular.module 'newAccountBook'
  .controller 'SignUpController', SignUpController

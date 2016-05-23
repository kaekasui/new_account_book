SignUpController = (AccountFactory, IndexService) ->
  'ngInject'
  vm = this
  vm.password = ''
  vm.password_confirmation = ''

  vm.submit = () ->
    IndexService.sending = true
    params = {
      email: vm.email
      password: vm.password
      password_confirmation: vm.password_confirmation
    }
    AccountFactory.postEmailUserRegistration(params).then((res) ->
      IndexService.sending = false
    ).catch (res) ->
      IndexService.sending = false
      vm.errors = res.error_messages
      vm.password = ''
      vm.password_confirmation = ''

  return

angular.module 'newAccountBook'
  .controller 'SignUpController', SignUpController

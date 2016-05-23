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
      vm.errors = res.error_messages
      vm.password = ''
      vm.password_confirmation = ''
      IndexService.sending = false

  return

angular.module 'newAccountBook'
  .controller 'SignUpController', SignUpController

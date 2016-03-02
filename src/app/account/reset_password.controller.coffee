ResetPasswordController = (AccountFactory, $translate) ->
  'ngInject'
  vm = this

  vm.clearErrors = () ->
    vm.errors = ''

  vm.submit = () ->
    vm.sending = true
    params = {
      email: vm.email
    }
    AccountFactory.postResetPassword(params).then((res) ->
      vm.sending = false
    ).catch (res) ->
      vm.errors = res.error_messages
      vm.sending = false

  return

angular.module 'newAccountBook'
  .controller 'ResetPasswordController', ResetPasswordController

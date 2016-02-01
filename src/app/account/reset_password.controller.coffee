ResetPasswordController = (AccountFactory, $translate) ->
  'ngInject'
  vm = this

  vm.clearErrors = () ->
    vm.errors = ''

  vm.submit = () ->
    params = {
      email: vm.email
    }

    AccountFactory.postResetPassword(params).catch (res) ->
      vm.errors = res.error_messages

  return

angular.module 'newAccountBook'
  .controller 'ResetPasswordController', ResetPasswordController

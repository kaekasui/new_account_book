ResetPasswordController = (AccountFactory, $translate, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    params = {
      email: vm.email
    }
    AccountFactory.postResetPassword(params).then((res) ->
      IndexService.sending = false
    ).catch (res) ->
      vm.errors = res.error_messages
      IndexService.sending = false

  return

angular.module 'newAccountBook'
  .controller 'ResetPasswordController', ResetPasswordController

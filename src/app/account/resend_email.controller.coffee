ResendEmailController = (AccountFactory, $translate) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    vm.sending = true
    params = {
      email: vm.email
    }
    AccountFactory.patchResendEmail(params).then((res) ->
      vm.sending = false
    ).catch (res) ->
      vm.errors = res.error_messages
      vm.sending = false

  return

angular.module 'newAccountBook'
  .controller 'ResendEmailController', ResendEmailController

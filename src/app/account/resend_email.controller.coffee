ResendEmailController = (AccountFactory, $translate) ->
  'ngInject'
  vm = this

  vm.clearErrors = () ->
    vm.errors = ''

  vm.submit = () ->
    vm.sending = true
    params = {
      email: vm.email
    }
    AccountFactory.patchResendEmail(params).then((res) ->
      vm.sending = false
    ).catch (res) ->
      if res.error_messages[0] == 'Not Found'
        vm.errors = [$translate.instant('MESSAGES.NOT_FOUND_EMAIL')]
      else
        vm.errors = res.error_messages
      vm.sending = false

  return

angular.module 'newAccountBook'
  .controller 'ResendEmailController', ResendEmailController

ResendEmailController = (AccountFactory, $translate) ->
  'ngInject'
  vm = this

  vm.clearErrors = () ->
    vm.errors = ''

  vm.submit = () ->
    params = {
      email: vm.email
    }
    AccountFactory.postResendEmail(params).catch (res) ->
      console.log res.error_messages
      if res.error_messages[0] == 'Not Found'
        vm.errors = [$translate.instant('MESSAGES.NOT_FOUND_EMAIL')]
      else
        vm.errors = res.error_messages

  return

angular.module 'newAccountBook'
  .controller 'ResendEmailController', ResendEmailController

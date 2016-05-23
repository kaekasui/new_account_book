ResendEmailController = (AccountFactory, $translate, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    params = {
      email: vm.email
    }
    AccountFactory.patchResendEmail(params).then((res) ->
      IndexService.sending = false
    ).catch (res) ->
      vm.errors = res.error_messages
      IndexService.sending = false

  return

angular.module 'newAccountBook'
  .controller 'ResendEmailController', ResendEmailController

ConfirmSendNewMailController = ($uibModalInstance, UserFactory, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    UserFactory.postNewMail().then ->
      $uibModalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('ConfirmSendNewMailController', ConfirmSendNewMailController)

ConfirmSendNewMailController = ($modalInstance, UserFactory, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    UserFactory.postNewMail().then ->
      $modalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('ConfirmSendNewMailController', ConfirmSendNewMailController)

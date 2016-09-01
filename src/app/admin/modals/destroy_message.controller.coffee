DestroyMessageController = (message_id, AdminFactory, $uibModalInstance, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    AdminFactory.deleteMessage(message_id).then ->
      $uibModalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyMessageController', DestroyMessageController)

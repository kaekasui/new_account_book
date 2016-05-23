DestroyMessageController = (message_id, AdminFactory, $modalInstance, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    AdminFactory.deleteMessage(message_id).then ->
      $modalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyMessageController', DestroyMessageController)

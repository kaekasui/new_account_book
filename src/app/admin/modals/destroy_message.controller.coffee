DestroyMessageController = (message_id, AdminFactory, $modalInstance) ->
  'ngInject'
  vm = this

  vm.ok = () ->
    AdminFactory.deleteMessage(message_id).then ->
      $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyMessageController', DestroyMessageController)

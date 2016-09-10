DestroyCaptureController = (capture_id, $uibModalInstance, IndexService, ImportFactory) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    ImportFactory.deleteCapture(capture_id).then ->
      $uibModalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyCaptureController', DestroyCaptureController)

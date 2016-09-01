DestroyRecordController = (record_id, RecordsFactory, $uibModalInstance, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    RecordsFactory.deleteRecord(record_id).then ->
      $uibModalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyRecordController', DestroyRecordController)

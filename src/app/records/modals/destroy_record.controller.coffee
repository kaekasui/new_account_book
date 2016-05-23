DestroyRecordController = (record_id, RecordsFactory, $modalInstance, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    RecordsFactory.deleteRecord(record_id).then ->
      $modalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyRecordController', DestroyRecordController)

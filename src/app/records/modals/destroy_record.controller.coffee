DestroyRecordController = (record_id, RecordsFactory, $modalInstance) ->
  'ngInject'
  vm = this

  vm.ok = () ->
    RecordsFactory.deleteRecord(record_id).then ->
      $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyRecordController', DestroyRecordController)

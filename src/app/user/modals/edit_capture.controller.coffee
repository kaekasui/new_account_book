EditCaptureController = (IndexService, RecordsFactory, capture, $modalInstance, SettingsFactory, $modal) ->
  'ngInject'
  vm = this
  vm.capture = capture.capture
  vm.user_currency = capture.user_currency
  vm.published_at = new Date(vm.capture.published_at)

  vm.cancel = () ->
    $modalInstance.dismiss()

  vm.submit = () ->
    IndexService.sending = true
    params =
      published_at: String(vm.published_at)
      category_id: vm.category_id
      breakdown_id: vm.breakdown_id
      place_id: vm.place_id
      charge: vm.charge
      memo: vm.memo
      tags: vm.tags
    # TODO: 更新できるようにする
    RecordsFactory.patchRecord(record_id, params).then((res) ->
      $modalInstance.close()
      IndexService.sending = false
    ).catch (res) ->
      IndexService.sending = false
      vm.errors = res.error_messages

  return
 
angular.module 'newAccountBook'
  .controller('EditCaptureController', EditCaptureController)

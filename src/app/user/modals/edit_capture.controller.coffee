EditCaptureController = (IndexService, UserFactory, capture, $modalInstance, $modal) ->
  'ngInject'
  vm = this
  vm.capture = capture.capture
  vm.user_currency = capture.user_currency
  vm.published_at = new Date(vm.capture.published_at)
  vm.category_name = vm.capture.category_name
  vm.breakdown_name = vm.capture.breakdown_name
  vm.place_name = vm.capture.place_name
  vm.tags = vm.capture.tags
  vm.charge = vm.capture.charge
  vm.memo = vm.capture.memo
  capture_id = vm.capture.id

  vm.cancel = () ->
    $modalInstance.dismiss()

  vm.submit = () ->
    IndexService.sending = true
    params =
      published_at: String(vm.published_at)
      category_name: vm.category_name
      breakdown_name: vm.breakdown_id
      place_name: vm.place_id
      charge: vm.charge
      memo: vm.memo
      tags: vm.tags
    UserFactory.patchCapture(capture_id, params).then((res) ->
      $modalInstance.close()
      IndexService.sending = false
    ).catch (res) ->
      IndexService.sending = false
      vm.errors = res.error_messages

  return
 
angular.module 'newAccountBook'
  .controller('EditCaptureController', EditCaptureController)

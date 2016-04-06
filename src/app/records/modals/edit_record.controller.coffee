EditRecordController = (IndexService, RecordsFactory, record_id, $modalInstance) ->
  'ngInject'
  vm = this
  vm.editing = false

  IndexService.modal_loading = true
  RecordsFactory.getEditRecord(record_id).then((res) ->
    vm.categories = res.categories
    vm.breakdown_field = res.user.breakdown_field
    vm.place_field = res.user.place_field
    vm.memo_field = res.user.memo_field
    vm.form_group_breakdown = vm.breakdown_field
    vm.form_group_place = vm.place_field
    vm.form_group_memo = vm.memo_field
    vm.record = res.record
    IndexService.modal_loading = false
  ).catch (res) ->
    IndexService.modal_loading = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  return
 
angular.module 'newAccountBook'
  .controller('EditRecordController', EditRecordController)

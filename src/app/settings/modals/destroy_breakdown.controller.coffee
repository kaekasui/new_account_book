DestroyBreakdownController = (SettingsFactory, $uibModalInstance, category_id, breakdown_id, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    SettingsFactory.deleteBreakdown(category_id, breakdown_id).then ->
      $uibModalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyBreakdownController', DestroyBreakdownController)

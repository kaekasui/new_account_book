DestroyBreakdownController = (SettingsFactory, $modalInstance, category_id, breakdown_id, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    SettingsFactory.deleteBreakdown(category_id, breakdown_id).then ->
      $modalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyBreakdownController', DestroyBreakdownController)

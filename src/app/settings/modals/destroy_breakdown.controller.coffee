DestroyBreakdownController = (SettingsFactory, $modalInstance, category_id, breakdown_id) ->
  'ngInject'
  vm = this

  vm.ok = () ->
    SettingsFactory.deleteBreakdown(category_id, breakdown_id).then ->
      $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyBreakdownController', DestroyBreakdownController)

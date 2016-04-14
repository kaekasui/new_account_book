DestroyCategoryController = (SettingsFactory, category_id, $modalInstance) ->
  'ngInject'
  vm = this

  vm.ok = () ->
    SettingsFactory.deleteCategory(category_id).then ->
      $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyCategoryController', DestroyCategoryController)

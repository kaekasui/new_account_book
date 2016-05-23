DestroyCategoryController = (SettingsFactory, category_id, $modalInstance, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    SettingsFactory.deleteCategory(category_id).then ->
      $modalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyCategoryController', DestroyCategoryController)

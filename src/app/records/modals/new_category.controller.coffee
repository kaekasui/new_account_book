NewCategoryController = ($uibModalInstance, SettingsFactory, IndexService) ->
  'ngInject'
  vm = this

  vm.new_payments = false

  vm.createCategory = () ->
    IndexService.sending = true
    params =
      name: vm.new_category_name
      barance_of_payments: vm.new_payments
    SettingsFactory.postCategory(params).then(() ->
      $uibModalInstance.close(vm.new_category_name)
      IndexService.sending = false
    ).catch (res) ->
      IndexService.sending = false
      vm.errors = res.error_messages

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('NewCategoryController', NewCategoryController)

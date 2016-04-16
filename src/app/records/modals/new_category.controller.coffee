NewCategoryController = ($modalInstance, SettingsFactory) ->
  'ngInject'
  vm = this

  vm.new_payments = false

  vm.createCategory = () ->
    params =
      name: vm.new_category_name
      barance_of_payments: vm.new_payments
    SettingsFactory.postCategory(params).then () ->
      SettingsFactory.getCategories().then (res) ->
        # TODO: カテゴリ一覧を取得
      $modalInstance.close(vm.new_category_name)

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('NewCategoryController', NewCategoryController)

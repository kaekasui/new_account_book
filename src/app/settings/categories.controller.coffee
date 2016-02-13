CategoriesController = (SettingsFactory, $modal) ->
  'ngInject'
  vm = this
  vm.add_field = false
  vm.new_payments = false

  SettingsFactory.getCategories().then (res) ->
    vm.categories = res.categories

  vm.addNewPanel = () ->
    vm.add_field = true

  vm.editCategory = (index) ->
    vm.categories[index].edit_field = true

  vm.createCategory = (e) ->
    if e.which == 13
      params =
        name: vm.new_category_name
        barance_of_payments: vm.new_payments
      SettingsFactory.postCategory(params).then () ->
        SettingsFactory.getCategories().then (res) ->
          vm.categories = res.categories
        vm.new_category_name = ''
        vm.add_field = false

  vm.updateCategoryEvent = (e, index) ->
    category = vm.categories[index]
    if (e.which == 13 && category.edit_name)
      SettingsFactory.patchCategory(category.id, {name: category.edit_name}).then () ->
        category.name = category.edit_name
        category.edit_field = false

  vm.updateCategory = (index) ->
    category = vm.categories[index]
    SettingsFactory.patchCategory(category.id, {name: category.edit_name}).then () ->
      category.name = category.edit_name
      category.edit_field = false

  vm.sortable =
    update: (e, ui) ->
      if (!ui.item.sortable.model)
        ui.item.sortable.cancel()
      else
        vm.category_range = []
        for key in vm.categories
          vm.category_range.push(key.id)
          SettingsFactory.postCategoryRange({sequence: vm.category_range})
      return
    axis: ''

  vm.destroyCategory = (index) ->
    category = vm.categories[index]
    modalInstance = $modal.open(
      templateUrl: 'confirm-destroy'
      controller: 'ConfirmDestroyController'
      controllerAs: 'confirm_destroy'
      resolve: { category_id: category.id }
    )
    modalInstance.result.then () ->
      SettingsFactory.getCategories().then (res) ->
        vm.categories = res.categories
      return

  return

ConfirmDestroyController = (SettingsFactory, category_id, $modalInstance) ->
  'ngInject'
  vm = this

  vm.ok = () ->
    SettingsFactory.deleteCategory(category_id).then ->
      $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('ConfirmDestroyController', ConfirmDestroyController)
  .controller('CategoriesController', CategoriesController)

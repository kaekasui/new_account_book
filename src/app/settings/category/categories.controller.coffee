CategoriesController = (SettingsFactory, $uibModal, IndexService) ->
  'ngInject'
  vm = this
  vm.add_field = false
  vm.new_payments = false

  IndexService.loading = true
  SettingsFactory.getCategories().then((res) ->
    vm.categories = res.categories
    vm.max_category_count = res.max_category_count
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  vm.addNewPanel = () ->
    vm.add_field = true

  vm.editCategory = (index) ->
    vm.categories[index].edit_payments = vm.categories[index].barance_of_payments
    vm.categories[index].edit_field = true

  vm.createCategory = () ->
    params =
      name: vm.new_category_name
      barance_of_payments: vm.new_payments
    SettingsFactory.postCategory(params).then () ->
      SettingsFactory.getCategories().then (res) ->
        vm.categories = res.categories
      vm.new_category_name = ''
      vm.add_field = false

  vm.updateCategory = (index) ->
    category = vm.categories[index]
    params =
      name: category.edit_name
      barance_of_payments: category.edit_payments
    SettingsFactory.patchCategory(category.id, params).then () ->
      category.name = category.edit_name
      category.barance_of_payments = category.edit_payments
      category.edit_field = false

  vm.sortable =
    stop: (e, ui) ->
      if (!ui.item.sortable.model)
        ui.item.sortable.cancel()
      else
        vm.category_range = []
        for key in vm.categories
          vm.category_range.push(key.id)
        SettingsFactory.postCategoryRange({sequence: vm.category_range})
      return
    axis: ''

  vm.showBreakdowns = (index) ->
    category = vm.categories[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/settings/modals/breakdowns.html'
      controller: 'BreakdownsController'
      controllerAs: 'breakdowns'
      resolve: { category_id: category.id }
    )
    modalInstance.result.finally () ->
      SettingsFactory.getCategories().then (res) ->
        vm.categories = res.categories
      return

  vm.showPlaces = (index) ->
    category = vm.categories[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/settings/modals/modal_places.html'
      controller: 'ModalPlacesController'
      controllerAs: 'modal_places'
      resolve: { category_id: category.id }
    )
    modalInstance.result.finally () ->
      SettingsFactory.getCategories().then (res) ->
        vm.categories = res.categories
      return

  vm.destroyCategory = (index) ->
    category = vm.categories[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/components/modals/destroy.html'
      controller: 'DestroyCategoryController'
      controllerAs: 'confirm_destroy'
      resolve: { category_id: category.id }
    )
    modalInstance.result.then () ->
      SettingsFactory.getCategories().then (res) ->
        vm.categories = res.categories
      return

  return

angular.module 'newAccountBook'
  .controller('CategoriesController', CategoriesController)

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
    vm.categories[index].edit_payments = vm.categories[index].barance_of_payments
    vm.categories[index].edit_field = true

  vm.createCategory = (e = undefined) ->
    if e == undefined || e.which == 13
      params =
        name: vm.new_category_name
        barance_of_payments: vm.new_payments
      SettingsFactory.postCategory(params).then () ->
        SettingsFactory.getCategories().then (res) ->
          vm.categories = res.categories
        vm.new_category_name = ''
        vm.add_field = false

  vm.updateCategory = (index, e = undefined) ->
    category = vm.categories[index]
    if e == undefined || (e.which == 13 && category.edit_name)
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
    modalInstance = $modal.open(
      templateUrl: 'breakdowns'
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
    modalInstance = $modal.open(
      templateUrl: 'modal-places'
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

BreakdownsController = (SettingsFactory, category_id, $modalInstance, $modal) ->
  'ngInject'
  vm = this

  SettingsFactory.getBreakdowns(category_id).then (res) ->
    vm.breakdowns = res.breakdowns

  vm.createBreakdown = (e) ->
    if e == undefined || e.which == 13
      params =
        name: vm.new_breakdown
      SettingsFactory.postBreakdown(category_id, params).then (res) ->
        vm.new_breakdown_field = false
        vm.new_breakdown = ''
        SettingsFactory.getBreakdowns(category_id).then (res) ->
          vm.breakdowns = res.breakdowns
    return

  vm.updateBreakdown = (index, e = undefined) ->
    breakdown = vm.breakdowns[index]
    if e == undefined || (e.which == 13 && breakdown.edit_name)
      SettingsFactory.patchBreakdown(category_id, breakdown.id, {name: breakdown.edit_name}).then () ->
        breakdown.name = breakdown.edit_name
        breakdown.edit_field = false
    return

  vm.destroyBreakdown = (index) ->
    breakdown = vm.breakdowns[index]
    modalInstance = $modal.open(
      templateUrl: 'confirm-destroy'
      controller: 'ConfirmDestroyBreakdownController'
      controllerAs: 'confirm_destroy'
      resolve:
        category_id: category_id
        breakdown_id: breakdown.id
    )
    modalInstance.result.then () ->
      SettingsFactory.getBreakdowns(category_id).then (res) ->
        vm.breakdowns = res.breakdowns
      return

  return

ModalPlacesController = (SettingsFactory, category_id, $modal) ->
  'ngInject'
  vm = this

  SettingsFactory.getCategoryPlaces(category_id).then (res) ->
    vm.places = res.places

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

ConfirmDestroyBreakdownController = (SettingsFactory, $modalInstance, category_id, breakdown_id) ->
  'ngInject'
  vm = this

  vm.ok = () ->
    SettingsFactory.deleteBreakdown(category_id, breakdown_id).then ->
      $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('BreakdownsController', BreakdownsController)
  .controller('ModalPlacesController', ModalPlacesController)
  .controller('ConfirmDestroyController', ConfirmDestroyController)
  .controller('ConfirmDestroyBreakdownController', ConfirmDestroyBreakdownController)
  .controller('CategoriesController', CategoriesController)

PlacesController = (SettingsFactory, $scope, IndexService, $modal, toastr, $translate) ->
  'ngInject'
  vm = this
  vm.add_field = false

  IndexService.loading = true
  SettingsFactory.getPlaces().then((res) ->
    vm.places = res.places
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  vm.newPlace = () ->
    vm.add_field = true

  vm.updatePlace = (index) ->
    place = vm.places[index]
    SettingsFactory.patchPlace(place.id, { name: place.edit_name }).then () ->
      SettingsFactory.getPlaces().then (res) ->
        vm.places = res.places
      place.edit_field = false

  vm.destroyPlace = (index) ->
    place = vm.places[index]
    modalInstance = $modal.open(
      templateUrl: 'app/components/modals/destroy.html'
      controller: 'DestroyPlaceController'
      controllerAs: 'confirm_destroy'
      resolve: { place_id: place.id }
    )
    modalInstance.result.then () ->
      SettingsFactory.getPlaces().then (res) ->
        vm.places = res.places

    return

  vm.addCategory = (index) ->
    place = vm.places[index]
    modalInstance = $modal.open(
      templateUrl: 'adding-category'
      controller: 'AddCategoryController'
      controllerAs: 'adding_category'
      resolve: { place_id: place.id }
    )
    modalInstance.result.then () ->
      SettingsFactory.getPlaceCategories(place.id).then (res) ->
        vm.places[index].categories = res.categories.filter (value, index, array) ->
          return value.selected_place
      return

  vm.removeCategory = (place_index, category_index) ->
    place = vm.places[place_index]
    category = vm.places[place_index].categories[category_index]
    SettingsFactory.deletePlaceCategory(place.id, category.id).then (res) ->
      console.log place.name
      console.log category.name
      SettingsFactory.getPlaceCategories(place.id).then (res) ->
        vm.places[place_index].categories = res.categories.filter (value, index, array) ->
          value.selected_place
        toastr.success($translate.instant('MESSAGES.REMOVE_CATEGORY', { place_name: place.name, category_name: category.name }))
    return

  vm.submit = () ->
    vm.sending = true
    params = { name: vm.new_name }
    SettingsFactory.postPlace(params).then((res) ->
      SettingsFactory.getPlaces().then (res) ->
        vm.places = res.places
      vm.new_name = ''
      vm.add_field = false
      vm.sending = false
    ).catch (res) ->
      vm.errors = res.error_messages
      vm.sending = false
    return

  return

AddCategoryController = ($modalInstance, SettingsFactory, place_id, IndexService) ->
  'ngInject'
  vm = this

  IndexService.modal_loading = true
  SettingsFactory.getPlaceCategories(place_id).then((res) ->
    vm.categories = res.categories
    IndexService.modal_loading = false
  ).catch (res) ->
    IndexService.modal_loading = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  vm.submit = () ->
    vm.sending = true
    SettingsFactory.patchPlaceCategory(place_id, vm.category_id).then((res) ->
      vm.sending = false
      $modalInstance.close()
    ).catch (res) ->
      vm.sending = false
    return

  return

angular.module 'newAccountBook'
  .controller('AddCategoryController', AddCategoryController)
  .controller('PlacesController', PlacesController)

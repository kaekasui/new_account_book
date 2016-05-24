PlacesController = (SettingsFactory, $scope, IndexService, $modal, toastr, $translate) ->
  'ngInject'
  vm = this
  vm.add_field = false

  IndexService.loading = true
  SettingsFactory.getPlaces().then((res) ->
    vm.places = res.places
    vm.max_place_count = res.max_place_count
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
      templateUrl: 'app/settings/modals/new_categorize.html'
      controller: 'NewCategorizeController'
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

angular.module 'newAccountBook'
  .controller('PlacesController', PlacesController)

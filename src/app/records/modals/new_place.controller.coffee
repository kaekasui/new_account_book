NewPlaceController = ($modalInstance, category_id, SettingsFactory) ->
  'ngInject'
  vm = this

  SettingsFactory.getCategoryPlaces(category_id).then (res) ->
    vm.category = res.category
    vm.places = res.places

  vm.createPlace = () ->
    params =
      name: vm.new_place_name
    SettingsFactory.postPlace(params).then (res) ->
      SettingsFactory.getPlaces().then (res) ->
        vm.places = res.places
        vm.places.forEach (p, i) ->
          if p.name == vm.new_place_name
            SettingsFactory.patchPlaceCategory(p.id, category_id).then (res) ->
              $modalInstance.close(p.id)

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('NewPlaceController', NewPlaceController)

DestroyPlaceController = (SettingsFactory, place_id, $modalInstance) ->
  'ngInject'
  vm = this

  vm.ok = () ->
    SettingsFactory.deletePlace(place_id).then (res) ->
      $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyPlaceController', DestroyPlaceController)

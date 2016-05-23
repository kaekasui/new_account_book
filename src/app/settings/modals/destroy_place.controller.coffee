DestroyPlaceController = (SettingsFactory, place_id, $modalInstance, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    SettingsFactory.deletePlace(place_id).then (res) ->
      $modalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyPlaceController', DestroyPlaceController)

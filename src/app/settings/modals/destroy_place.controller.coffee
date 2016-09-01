DestroyPlaceController = (SettingsFactory, place_id, $uibModalInstance, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    SettingsFactory.deletePlace(place_id).then (res) ->
      $uibModalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyPlaceController', DestroyPlaceController)

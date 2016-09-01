NewCategorizeController = ($uibModalInstance, SettingsFactory, place_id, IndexService) ->
  'ngInject'
  vm = this

  IndexService.modal_loading = true
  SettingsFactory.getPlaceCategories(place_id).then((res) ->
    vm.categories = res.categories
    IndexService.modal_loading = false
  ).catch (res) ->
    IndexService.modal_loading = false

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  vm.submit = () ->
    vm.sending = true
    SettingsFactory.patchPlaceCategory(place_id, vm.category_id).then((res) ->
      vm.sending = false
      $uibModalInstance.close()
    ).catch (res) ->
      vm.sending = false

  return

angular.module 'newAccountBook'
  .controller('NewCategorizeController', NewCategorizeController)

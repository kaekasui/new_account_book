NewPlaceController = ($uibModalInstance, category_id, SettingsFactory, IndexService) ->
  'ngInject'
  vm = this

  SettingsFactory.getCategoryPlaces(category_id).then (res) ->
    vm.category = res.category
    vm.places = res.user_places

  vm.submit = () ->
    IndexService.sending = true
    params =
      name: vm.new_place_name
    SettingsFactory.postCategoryPlace(category_id, params).then((res) ->
      $uibModalInstance.close(res.id)
      IndexService.sending = false
    ).catch (res) ->
      IndexService.sending = false
      vm.errors = res.error_messages

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('NewPlaceController', NewPlaceController)

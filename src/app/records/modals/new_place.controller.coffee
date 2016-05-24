NewPlaceController = ($modalInstance, category_id, SettingsFactory, IndexService) ->
  'ngInject'
  vm = this

  SettingsFactory.getCategoryPlaces(category_id).then((res) ->
    vm.category = res.category
    vm.places = res.places

  vm.submit = () ->
    IndexService.sending = true
    params =
      name: vm.new_place_name
    SettingsFactory.postCategoryPlace(category_id, params).then((res) ->
      $modalInstance.close(res.id)
      IndexService.sending = false
    ).catch (res) ->
      IndexService.sending = false
      vm.errors = res.error_messages

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('NewPlaceController', NewPlaceController)

NewPlaceController = ($modalInstance, category_id, SettingsFactory, IndexService) ->
  'ngInject'
  vm = this

  SettingsFactory.getCategoryPlaces(category_id).then((res) ->
    vm.category = res.category
    vm.places = res.places
  ).catch (res) ->
    vm.errors = res.error_messages
  # TODO: 上記を削除する

  vm.createPlace = () ->
    IndexService.sending = true
    params =
      name: vm.new_place_name
    SettingsFactory.postCategoryPlace(category_id, params).then((res) ->
      $modalInstance.close(res.id)
      IndexService.sending = false
    ).catch (res) ->
      IndexService.sending = false
      vm.errors = res.error_messages
    # TODO: patchCategoryAndPlace
    #IndexService.sending = true
    #SettingsFactory.postPlace(params).then((res) ->
    #  SettingsFactory.getPlaces().then (res) ->
    #    vm.places = res.places
    #    vm.places.forEach (p, i) ->
    #      if p.name == vm.new_place_name
    #        SettingsFactory.patchPlaceCategory(p.id, category_id).then (res) ->
    #          $modalInstance.close(p.id)
    #  IndexService.sending = false
    #).catch (res) ->
    #  vm.errors = res.error_messages
    #  IndexService.sending = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('NewPlaceController', NewPlaceController)

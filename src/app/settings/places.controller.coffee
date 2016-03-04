PlacesController = (SettingsFactory, $scope, IndexService) ->
  'ngInject'
  vm = this
  vm.add_field = false

  vm.newPlace = () ->
    vm.add_field = true

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

  IndexService.loading = true
  SettingsFactory.getPlaces().then((res) ->
    vm.places = res.places
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  return

angular.module 'newAccountBook'
  .controller('PlacesController', PlacesController)

PlacesController = (SettingsFactory, $scope) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    vm.sending = true
    params = { name: vm.new_name }
    SettingsFactory.postPlace(params).then((res) ->
      SettingsFactory.getPlaces().then (res) ->
        vm.places = res.places
      vm.new_name = ''
      $scope.newPlaceForm.$setPristine()
      vm.sending = false
    ).catch (res) ->
      vm.errors = res.error_messages
      vm.sending = false
    return

  SettingsFactory.getPlaces().then (res) ->
    vm.places = res.places

  return

angular.module 'newAccountBook'
  .controller('PlacesController', PlacesController)

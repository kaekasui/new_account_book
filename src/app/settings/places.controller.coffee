PlacesController = (SettingsFactory) ->
  'ngInject'
  vm = this

  SettingsFactory.getPlaces().then (res) ->
    vm.places = res.places

  return

angular.module 'newAccountBook'
  .controller('PlacesController', PlacesController)

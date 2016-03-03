PlacesController = (SettingsFactory) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    params = { name: vm.new_name }
    SettingsFactory.postPlace(params).then (res) ->
      SettingsFactory.getPlaces().then (res) ->
        vm.places = res.places
      vm.new_name = ''
    return

  SettingsFactory.getPlaces().then (res) ->
    vm.places = res.places

  return

angular.module 'newAccountBook'
  .controller('PlacesController', PlacesController)

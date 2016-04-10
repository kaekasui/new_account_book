BaseSettingsController = (RecordsFactory, IndexService, SettingsFactory) ->
  # TODO: RecordsFactory.patchSettingsをSettingsに移動する
  'ngInject'
  vm = this

  IndexService.loading = true
  SettingsFactory.getCurrentUserSettings().then((res) ->
    vm.breakdown_field = res.breakdown_field
    vm.place_field = res.place_field
    vm.tag_field = res.tag_field
    vm.memo_field = res.memo_field
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  vm.checkSetting = () ->
    params =
      breakdown_field: vm.breakdown_field
      place_field: vm.place_field
      tag_field: vm.tag_field
      memo_field: vm.memo_field
    RecordsFactory.patchSettings(params).then (res) ->
      vm.form_group_breakdown = vm.breakdown_field
      vm.form_group_place = vm.place_field
      vm.form_group_tag = vm.tag_field
      vm.form_group_memo = vm.memo_field
    return

  return

angular.module 'newAccountBook'
  .controller('BaseSettingsController', BaseSettingsController)

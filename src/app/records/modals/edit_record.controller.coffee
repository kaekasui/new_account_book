EditRecordController = (IndexService, RecordsFactory, record_id, $modalInstance, SettingsFactory, $modal) ->
  'ngInject'
  vm = this
  vm.editing = false

  setData = () ->
    vm.published_at = new Date(vm.record.published_at)
    vm.categories.forEach (c, i) ->
      if c.name == vm.record.category_name
        vm.category_id = c.id
        vm.breakdowns = c.breakdowns
        vm.breakdowns.forEach (b, j) ->
          if b.name == vm.record.breakdown_name
            vm.breakdown_id = b.id
        vm.places = c.places
        vm.places.forEach (p, k) ->
          if p.name == vm.record.place_name
            vm.place_id = p.id
      if vm.record.breakdown_name == null
        vm.breakdown_id = ''
      if vm.record.place_name == null
        vm.place_id = ''
    vm.charge = vm.record.charge
    vm.memo = vm.record.memo
    vm.tags = vm.record.tags
    return

  IndexService.modal_loading = true
  RecordsFactory.getEditRecord(record_id).then((res) ->
    vm.categories = res.categories
    vm.user = res.user # TODO: 以下の_fieldを指定しないようにする
    vm.breakdown_field = res.user.breakdown_field
    vm.place_field = res.user.place_field
    vm.memo_field = res.user.memo_field
    vm.form_group_breakdown = vm.breakdown_field
    vm.form_group_place = vm.place_field
    vm.form_group_memo = vm.memo_field
    vm.record = res.record
    setData()
    IndexService.modal_loading = false
  ).catch (res) ->
    IndexService.modal_loading = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  vm.setToday = () ->
    vm.published_at = new Date()

  vm.submit = () ->
    params =
      published_at: String(vm.published_at)
      category_id: vm.category_id
      breakdown_id: vm.breakdown_id
      place_id: vm.place_id
      charge: vm.charge
      memo: vm.memo
      tags: vm.tags
    RecordsFactory.patchRecord(record_id, params).then((res) ->
      $modalInstance.close()
    ).catch (res) ->
      vm.errors = res.error_messages

  vm.selectCategory = () ->
    vm.categories.forEach (item, i) ->
      if item.id == vm.category_id
        vm.breakdowns = item.breakdowns
        vm.places = item.places

  vm.loadTags = ($query) ->
    SettingsFactory.getTags().then (res) ->
      tags = res.tags
      tags.filter (tag) ->
        return tag.name.indexOf($query) != -1

  # モーダル
  vm.setColor = ($tag) ->
    modalInstance = $modal.open(
      templateUrl: 'app/records/modals/color_code.html'
      controller: 'ColorCodeController'
      controllerAs: 'color_code'
      resolve: { tag: $tag }
    )
    modalInstance.result.then () ->
      return

  return
 
angular.module 'newAccountBook'
  .controller('EditRecordController', EditRecordController)

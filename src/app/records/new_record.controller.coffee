NewRecordController = (IndexService, toastr, RecordsFactory, $scope) ->
  'ngInject'
  vm = this

  vm.published_at = new Date()
  vm.settings = false

  IndexService.records_loading = true
  IndexService.loading = true
  RecordsFactory.getNewRecord().then((res) ->
    vm.categories = res.categories
    vm.breakdown_field = res.user.breakdown_field
    vm.place_field = res.user.place_field
    vm.memo_field = res.user.memo_field
    vm.form_group_breakdown = vm.breakdown_field
    vm.form_group_place = vm.place_field
    vm.form_group_memo = vm.memo_field
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  params =
    published_at: vm.published_at
  RecordsFactory.getRecords(params).then((res) ->
    vm.day_records = res.records
    IndexService.records_loading = false
  ).catch (res) ->
    IndexService.records_loading = false

  vm.submit = () ->
    category = vm.categories[vm.category_index_id]
    if category
      vm.category_id = category.id
    params =
      published_at: String(vm.published_at)
      category_id: vm.category_id
      breakdown_id: vm.breakdown_id
      place_id: vm.place_id
      charge: vm.charge
      memo: vm.memo
    RecordsFactory.postRecord(params).then (res) ->
      vm.category_index_id = ''
      vm.breakdown_id = ''
      vm.place_id = ''
      vm.charge = ''
      vm.memo = ''
      $scope.newRecordForm.$setPristine()
      # TODO: コピーのリンクと編集のリンクを表示する
      params =
        published_at: vm.published_at
      RecordsFactory.getRecords(params).then((res) ->
        vm.day_records = res.records
        IndexService.records_loading = false
      ).catch (res) ->
        IndexService.records_loading = false

    return

  vm.selectCategory = (category_index_id) ->
    vm.breakdowns = vm.categories[category_index_id].breakdowns
    vm.places = vm.categories[category_index_id].places
    return

  vm.checkSetting = () ->
    params =
      breakdown_field: vm.breakdown_field
      place_field: vm.place_field
      memo_field: vm.memo_field
    RecordsFactory.patchSettings(params).then (res) ->
      vm.form_group_breakdown = vm.breakdown_field
      vm.form_group_place = vm.place_field
      vm.form_group_memo = vm.memo_field
    return

  vm.changeDate = () ->
    params =
      published_at: vm.published_at
    RecordsFactory.getRecords(params).then((res) ->
      vm.day_records = res.records
      IndexService.records_loading = false
    ).catch (res) ->
      IndexService.records_loading = false
    return

  return
 
angular.module 'newAccountBook'
  .controller('NewRecordController', NewRecordController)

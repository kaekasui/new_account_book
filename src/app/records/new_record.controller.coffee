NewRecordController = (IndexService, toastr, RecordsFactory, $scope, $modal) ->
  'ngInject'
  vm = this

  vm.published_at = new Date()
  vm.settings = false

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

  # 対象の登録一覧を取得する関数
  getRecordsWithDate = () ->
    IndexService.records_loading = true
    params =
      date: vm.published_at
    RecordsFactory.getRecords(params).then((res) ->
      vm.day_records = res.records
      IndexService.records_loading = false
    ).catch (res) ->
      IndexService.records_loading = false
    return
 
  getRecordsWithDate()

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
      # TODO: 編集のリンクを表示する
      getRecordsWithDate()
    return

  vm.selectCategory = () ->
    vm.categories.forEach (item, i) ->
      if item.id == vm.category_id
        vm.breakdowns = item.breakdowns
        vm.places = item.places

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
    getRecordsWithDate()

  vm.copyRecord = (record) ->
    vm.categories.forEach (c, i) ->
      if c.name == record.category_name
        vm.category_id = c.id
        vm.breakdowns = c.breakdowns
        vm.breakdowns.forEach (b, j) ->
          if b.name == record.breakdown_name
            vm.breakdown_id = b.id
        vm.places = c.places
        vm.places.forEach (p, k) ->
          if p.name == record.place_name
            vm.place_id = p.id
      if record.breakdown_name == null
        vm.breakdown_id = ''
      if record.place_name == null
        vm.place_id = ''
    vm.charge = record.charge
    vm.memo = record.memo

  vm.setToday = () ->
    vm.published_at = new Date()
    getRecordsWithDate()

  # モーダル
  vm.showRecord = (index) ->
    record = vm.day_records[index]
    modalInstance = $modal.open(
      templateUrl: 'app/records/modals/record.html'
      controller: 'EditRecordController'
      controllerAs: 'edit_record'
      resolve: { record_id: record.id }
      backdrop: 'static'
    )
    modalInstance.result.then () ->
      RecordsFactory.getRecord(record.id).then (res) ->
        vm.day_records[index] = res

  vm.destroyRecord = (index) ->
    record = vm.day_records[index]
    modalInstance = $modal.open(
      templateUrl: 'app/components/modals/destroy.html'
      controller: 'DestroyRecordController'
      controllerAs: 'confirm_destroy'
      resolve: { record_id: record.id }
    )
    modalInstance.result.then () ->
      getRecordsWithDate()

  return
 
angular.module 'newAccountBook'
  .controller('NewRecordController', NewRecordController)

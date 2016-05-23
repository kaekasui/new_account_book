NewRecordController = (IndexService, toastr, RecordsFactory, $scope, $modal, SettingsFactory) ->
  'ngInject'
  vm = this

  vm.published_at = new Date()
  vm.records_published_at = new Date()
  vm.settings = false

  IndexService.loading = true
  RecordsFactory.getNewRecord().then((res) ->
    vm.categories = res.categories
    vm.total_record_count = res.total_record_count
    vm.breakdown_field = res.user.breakdown_field
    vm.place_field = res.user.place_field
    vm.tag_field = res.user.tag_field
    vm.memo_field = res.user.memo_field
    vm.user = res.user
    vm.form_group_breakdown = vm.breakdown_field
    vm.form_group_place = vm.place_field
    vm.form_group_tag = vm.tag_field
    vm.form_group_memo = vm.memo_field
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  # 対象の登録一覧を取得する関数
  getRecordsWithDate = (target_date) ->
    IndexService.records_loading = true
    params =
      date: String(target_date)
    RecordsFactory.getRecords(params).then((res) ->
      vm.records_published_at = target_date
      vm.day_records = res.records
      IndexService.records_loading = false
    ).catch (res) ->
      IndexService.records_loading = false
    return
 
  getRecordsWithDate(vm.published_at)

  # 「登録」ボタン
  vm.submit = () ->
    IndexService.sending = true
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
      tags: vm.tags
    RecordsFactory.postRecord(params).then((res) ->
      $scope.newRecordForm.$submitted = false
      vm.category_index_id = ''
      vm.breakdown_id = ''
      vm.place_id = ''
      vm.charge = ''
      vm.memo = ''
      vm.tags = ''
      console.log $scope.newRecordForm.$submitted
      IndexService.sending = false
      $scope.newRecordForm.$setPristine()
      getRecordsWithDate(vm.published_at)
    ).catch (res) ->
      IndexService.sending = false

  # 「<」ボタン
  vm.getYesterdayRecords = () ->
    vm.records_published_at.setDate(vm.records_published_at.getDate() - 1)
    getRecordsWithDate(vm.records_published_at)

  # 「>」ボタン
  vm.getTomorrowRecords = () ->
    vm.records_published_at.setDate(vm.records_published_at.getDate() + 1)
    getRecordsWithDate(vm.records_published_at)

  # 「カテゴリ」選択
  vm.selectCategory = () ->
    vm.categories.forEach (item, i) ->
      if item.id == vm.category_id
        vm.breakdowns = item.breakdowns
        vm.places = item.places

  # 表示設定のチェック
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

  # 日付変更
  vm.changeDate = () ->
    getRecordsWithDate(vm.published_at)

  # コピーアイコン
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
    vm.tags = record.tags
    vm.memo = record.memo

  # 「今日」ボタン
  vm.setToday = () ->
    vm.published_at = new Date()
    getRecordsWithDate(vm.published_at)

  # ドロップダウンリスト
  vm.loadTags = ($query) ->
    SettingsFactory.getTags().then (res) ->
      tags = res.tags
      tags.filter (tag) ->
        return tag.name.indexOf($query) != -1

  # カテゴリ「追加」ボタン -> モーダル
  vm.newCategory = () ->
    modalInstance = $modal.open(
      templateUrl: 'app/records/modals/new_category.html'
      controller: 'NewCategoryController'
      controllerAs: 'new_category'
      backdrop: 'static'
    )
    modalInstance.result.then (category_name) ->
      RecordsFactory.getNewRecord().then((res) ->
        vm.categories = res.categories
        vm.categories.forEach (c, i) ->
          if c.name == category_name
            vm.category_id = c.id
      )

  # 内訳「追加」ボタン モーダル
  vm.newBreakdown = () ->
    modalInstance = $modal.open(
      templateUrl: 'app/records/modals/new_breakdown.html'
      controller: 'NewBreakdownController'
      controllerAs: 'new_breakdown'
      backdrop: 'static'
      resolve: { category_id: vm.category_id }
    )
    modalInstance.result.then (breakdown_name) ->
      SettingsFactory.getBreakdowns(vm.category_id).then (res) ->
        vm.breakdowns = res.breakdowns
        vm.breakdowns.forEach (b, j) ->
          if b.name == breakdown_name
            vm.breakdown_id = b.id

  # お店・施設「追加」ボタン モーダル
  vm.newPlace = () ->
    modalInstance = $modal.open(
      templateUrl: 'app/records/modals/new_place.html'
      controller: 'NewPlaceController'
      controllerAs: 'new_place'
      backdrop: 'static'
      resolve: { category_id: vm.category_id }
    )
    modalInstance.result.then (place_id) ->
      SettingsFactory.getCategoryPlaces(vm.category_id).then (res) ->
        vm.places = res.places
        vm.place_id = place_id

  # 情報アイコン モーダル
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
      getRecordsWithDate(vm.published_at)

  # 削除アイコン モーダル
  vm.destroyRecord = (index) ->
    record = vm.day_records[index]
    modalInstance = $modal.open(
      templateUrl: 'app/components/modals/destroy.html'
      controller: 'DestroyRecordController'
      controllerAs: 'confirm_destroy'
      resolve: { record_id: record.id }
    )
    modalInstance.result.then () ->
      getRecordsWithDate(vm.published_at)

  # ラベル名 モーダル
  vm.setColor = ($tag) ->
    modalInstance = $modal.open(
      templateUrl: 'app/records/modals/color_code.html'
      controller: 'ColorCodeController'
      controllerAs: 'color_code'
      resolve: { tag: $tag }
    )
    modalInstance.result.then () ->
      return

  # ラベル：ヘルプ モーダル
  vm.helpTags = () ->
    modalInstance = $modal.open(
      templateUrl: 'app/records/modals/help_tags.html'
    )
    modalInstance.result.then () ->
      return

  return
 
angular.module 'newAccountBook'
  .controller('NewRecordController', NewRecordController)

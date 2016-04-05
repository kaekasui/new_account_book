RecordsController = ($filter, IndexService , RecordsFactory, localStorageService, $modal) ->
  'ngInject'
  vm = this
  vm.offset = 0
  vm.years = [2012..2017]
  vm.months = [1..12]
  vm.selected_list = localStorageService.get('selected_list') || 'month'

  vm.day = new Date()
  vm.year = Number($filter('date')(vm.day, 'yyyy'))
  vm.month = Number($filter('date')(vm.day, 'MM'))

  # 登録情報を取得する関数
  getRecordsWithDate = () ->
    IndexService.loading = true
    params = if vm.selected_list == 'day'
      date: vm.day
      offset: vm.offset
    else if vm.selected_list == 'month'
      year: vm.year
      month: vm.month
      offset: vm.offset
    else if vm.selected_list == 'year'
      year: vm.year
      offset: vm.offset
    RecordsFactory.getRecords(params).then((res) ->
      vm.records = res.records
      vm.total_count = res.total_count
      total_array = []
      for i in [0..vm.total_count]
        total_array.push(i)
      vm.offset_numbers = total_array.filter (x) ->
        return x % 20 == 0
      IndexService.loading = false
    ).catch (res) ->
      IndexService.loading = false

  # 日
  vm.selectDayList = () ->
    localStorageService.set 'selected_list', 'day'
    vm.selected_list = 'day'
    vm.offset = 0
    getRecordsWithDate()

  vm.changeDate = () ->
    vm.offset = 0
    getRecordsWithDate()

  # 月
  vm.selectMonthList = () ->
    localStorageService.set 'selected_list', 'month'
    vm.selected_list = 'month'
    vm.offset = 0
    getRecordsWithDate()

  vm.selectMonth = (month) ->
    vm.month = month
    vm.offset = 0
    getRecordsWithDate()

  vm.selectYearMonth = (year) ->
    vm.year = year
    vm.offset = 0
    getRecordsWithDate()

  # 年
  vm.selectYearList = () ->
    localStorageService.set 'selected_list', 'year'
    vm.selected_list = 'year'
    vm.offset = 0
    getRecordsWithDate()

  vm.selectYear = (year) ->
    vm.year = year
    vm.offset = 0
    getRecordsWithDate()

  # ページング
  vm.clickPaginate = (offset) ->
    vm.offset = offset
    getRecordsWithDate()

  # モーダル
  vm.showRecord = (index) ->
    record = vm.records[index]
    modalInstance = $modal.open(
      templateUrl: 'app/records/modals/record.html'
      controller: 'EditRecordController'
      controllerAs: 'edit_record'
      resolve: { record_id: record.id }
    )
    modalInstance.result.then () ->
      getRecordsWithDate() # TODO: 対象のレコードのみ更新

    return

  # リスト表示
  getRecordsWithDate()

  return

angular.module 'newAccountBook'
  .controller('RecordsController', RecordsController)

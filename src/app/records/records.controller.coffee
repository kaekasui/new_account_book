RecordsController = ($filter, IndexService , RecordsFactory, localStorageService, $uibModal, $stateParams, $state) ->
  'ngInject'
  vm = this
  vm.offset = 0
  vm.years = [2012..2017]
  vm.months = [1..12]
  vm.selected_list = localStorageService.get('selected_list') || 'month'
  vm.today = new Date()
  vm.today_year = Number($filter('date')(vm.today, 'yyyy'))
  vm.today_month = Number($filter('date')(vm.today, 'MM'))
  vm.today_day = Number($filter('date')(vm.today, 'dd'))

  # 登録情報を取得する関数
  getRecordsWithDate = () ->
    IndexService.loading = true
    params =
      year: vm.year
      month: vm.month
      day: vm.day
      offset: vm.offset
    RecordsFactory.getRecords(params).then((res) ->
      vm.records = res.records
      vm.total_count = res.total_count
      vm.user = res.user
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

  # 日付の変更
  vm.changeDate = () ->
    vm.offset = 0
    $state.go('daily_list',
      year: Number($filter('date')(vm.date, 'yyyy'))
      month: ('0' + Number($filter('date')(vm.date, 'MM'))).slice(-2)
      day: ('0' + Number($filter('date')(vm.date, 'dd'))).slice(-2)
    )

  # 月
  vm.selectMonthList = () ->
    localStorageService.set 'selected_list', 'month'
    vm.selected_list = 'month'
    vm.offset = 0

  # 年を切り替えるレセクトボックス
  vm.selectYearMonth = (year) ->
    vm.year = year
    vm.offset = 0
    getRecordsWithDate()

  # 年
  vm.selectYearList = () ->
    localStorageService.set 'selected_list', 'year'
    vm.selected_list = 'year'
    vm.offset = 0

  # 年を切り替えるセレクトボックス
  vm.selectYear = (year) ->
    vm.year = year
    vm.offset = 0
    getRecordsWithDate()

  if $stateParams.day
    vm.day = $stateParams.day
    vm.selectDayList()
  else if $stateParams.month
    vm.selectMonthList()
  else if $stateParams.year
    vm.selectYearList()
  else
    if vm.selected_list == 'year'
      $state.go('yearly_list', { year: vm.today_year })
    else if vm.selected_list == 'month'
      $state.go('monthly_list', { year: vm.today_year, month: vm.today_month })
    else
      $state.go('daily_list', { year: vm.today_year, month: vm.today_month, day: vm.today_day })

  vm.year = Number($stateParams.year)
  vm.month = Number($stateParams.month)
  vm.day = Number($stateParams.day)
  vm.date = new Date(vm.year, vm.month - 1, vm.day)

  # ページング
  vm.clickPaginate = (offset) ->
    vm.offset = offset
    getRecordsWithDate()

  # モーダル
  vm.showRecord = (index) ->
    record = vm.records[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/components/records/modals/record.html'
      controller: 'EditRecordController'
      controllerAs: 'edit_record'
      resolve: { record_id: record.id }
      backdrop: 'static'
    )
    modalInstance.result.then () ->
      RecordsFactory.getRecord(record.id).then (res) ->
        vm.records[index] = res

  vm.destroyRecord = (index) ->
    record = vm.records[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/components/modals/destroy.html'
      controller: 'DestroyRecordController'
      controllerAs: 'confirm_destroy'
      resolve: { record_id: record.id }
    )
    modalInstance.result.then () ->
      getRecordsWithDate()

  # CSV形式でダウンロード
  vm.downloadCSV = () ->
    IndexService.loading = true
    vm.downloading = true
    params =
      year: vm.year
      month: vm.month
      day: vm.day
      offset: vm.offset
    RecordsFactory.getCSVRecords(params).then((res) ->
      if window.navigator.msSaveOrOpenBlob
        blob = new Blob([ decodeURIComponent(encodeURI(result.data)) ], type: 'text/csv;charset=utf-8;')
        navigator.msSaveBlob(blob, 'list.csv')
      else
        a = document.createElement('a')
        a.href = 'data:attachment/csv;charset=utf-8,' + encodeURI(res)
        a.target = '_blank'
        a.download = 'list.csv'
        document.body.appendChild(a)
        a.click()
      IndexService.loading = false
      vm.downloading = false
    ).catch (res) ->
      IndexService.loading = false
      vm.downloading = false

  getRecordsWithDate()

  return

angular.module 'newAccountBook'
  .controller('RecordsController', RecordsController)

RecordsController = ($filter, IndexService, IndexFactory, RecordsFactory) ->
  'ngInject'
  vm = this
  vm.offset = 0
  vm.years = [2012..2017]
  vm.months = [1..12]
  IndexFactory.getCurrentUser().then((res) ->
    vm.current_user = res
    vm.selected_list = 'month'

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
      vm.selected_list = res.date_setting
      total_array = []
      for i in [0..vm.total_count]
        total_array.push(i)
      vm.offset_numbers = total_array.filter (x) ->
        return x % 20 == 0
      IndexService.loading = false
    ).catch (res) ->
      IndexService.loading = false

  # 日
  if vm.selected_list == 'day'
    getRecordsWithDate()

  vm.selectDayList = () ->
    vm.selected_list = 'day'
    vm.offset = 0
    getRecordsWithDate()

  vm.changeDate = () ->
    vm.offset = 0
    getRecordsWithDate()

  # 月
  if vm.selected_list == 'month'
    getRecordsWithDate()

  vm.selectMonthList = () ->
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

  return
 
angular.module 'newAccountBook'
  .controller('RecordsController', RecordsController)

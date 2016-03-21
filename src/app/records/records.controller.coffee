RecordsController = ($filter, IndexService , RecordsFactory) ->
  'ngInject'
  vm = this
  vm.offset = 0
  vm.years = [2012..2017]
  vm.months = [1..12]
  # TODO: 年、月、日の設定を取得
  vm.selected_list = 'day'

  vm.day = new Date()
  vm.year = Number($filter('date')(vm.day, 'yyyy'))
  vm.month = Number($filter('date')(vm.day, 'MM'))

  # 登録情報を取得する関数
  getRecordsWithDate = () ->
    IndexService.loading = true
    params =
      published_at: vm.day
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
  vm.selectMonthList = () ->
    vm.selected_list = 'month'
 
  # 年
  vm.selectYearList = () ->
    vm.selected_list = 'year'

  vm.selectMonth = (month) ->
    vm.month = month

  vm.clickPaginate = (offset) ->
    vm.offset = offset
    getRecordsWithDate()

  return
 
angular.module 'newAccountBook'
  .controller('RecordsController', RecordsController)

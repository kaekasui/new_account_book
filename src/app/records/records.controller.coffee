RecordsController = ($filter) ->
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

  vm.selectYearList = () ->
    vm.selected_list = 'year'

  vm.selectMonthList = () ->
    vm.selected_list = 'month'
 
  vm.selectDayList = () ->
    vm.selected_list = 'day'

  vm.changeList = () ->
    console.log 'change'

  vm.selectMonth = (month) ->
    vm.month = month

  vm.clickPaginate = (offset) ->
    console.log 'offset'

  return
 
angular.module 'newAccountBook'
  .controller('RecordsController', RecordsController)

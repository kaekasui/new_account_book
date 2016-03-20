RecordsController = ($filter) ->
  'ngInject'
  vm = this
  # TODO: 年、月、日の設定を取得
  vm.year_list = false
  vm.month_list = false
  vm.day_list = true
  vm.day = new Date()
  vm.year = Number($filter('date')(vm.day, 'yyyy'))
  vm.month = Number($filter('date')(vm.day, 'MM'))

  vm.years = [2012..2017]
  vm.months = [1..12]

  vm.selectYearList = () ->
    vm.year_list = true
    vm.month_list = false
    vm.day_list = false

  vm.selectMonthList = () ->
    vm.year_list = false
    vm.month_list = true
    vm.day_list = false
 
  vm.selectDayList = () ->
    vm.year_list = false
    vm.month_list = false
    vm.day_list = true
    return

  vm.changeList = () ->
    console.log 'change'
    

  return
 
angular.module 'newAccountBook'
  .controller('RecordsController', RecordsController)

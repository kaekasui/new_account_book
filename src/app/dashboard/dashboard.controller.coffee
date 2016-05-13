DashboardController = () ->
  'ngInject'
  vm = this

  vm.today = new Date()
  vm.target_year = vm.today.getFullYear()
  vm.target_month = vm.today.getMonth()
  vm.new_date = new Date()

  vm.getPrevMonthData = () ->
    vm.new_date.setMonth(vm.target_month - 1)
    vm.target_year = vm.new_date.getFullYear()
    vm.target_month = vm.new_date.getMonth()

  vm.getNextMonthData = () ->
    if vm.today > vm.new_date
      vm.new_date.setMonth(vm.target_month + 1)
      vm.target_year = vm.new_date.getFullYear()
      vm.target_month = vm.new_date.getMonth()

  return

angular.module 'newAccountBook'
  .controller('DashboardController', DashboardController)

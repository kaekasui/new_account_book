DashboardController = () ->
  'ngInject'
  vm = this

  vm.dailyData = [40, 88, 10]
  return

angular.module 'newAccountBook'
  .controller('DashboardController', DashboardController)

DashboardController = (DashboardFactory) ->
  'ngInject'
  vm = this

  today = new Date()
  vm.target_year = today.getFullYear()
  vm.target_month = today.getMonth()

  return

angular.module 'newAccountBook'
  .controller('DashboardController', DashboardController)

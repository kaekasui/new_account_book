DashboardController = () ->
  'ngInject'
  vm = this

  today = new Date()
  vm.target_year = today.getFullYear()
  vm.target_month = today.getMonth()

  vm.dailyData = [
    {
      date: new Date(2016, vm.target_month, 1)
      plus: 120
      minus: 800
    },
    {
      date: new Date(2016, vm.target_month, 15)
      plus: 10
      minus: 434
    }
  ]
  return

angular.module 'newAccountBook'
  .controller('DashboardController', DashboardController)

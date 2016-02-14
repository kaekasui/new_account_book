NoticesController = (AdminFactory) ->
  'ngInject'
  vm = this

  vm.offset = 0
  vm.clickPaginate = (offset) ->
    vm.offset = offset
    AdminFactory.getNotices(vm.offset).then (res) ->
      vm.notices = res.notices
      vm.total_count = res.total_count
      total_array = []
      for i in [0..vm.total_count]
        total_array.push(i)
      vm.offset_numbers = total_array.filter (x) ->
        return x % 20 == 0

  AdminFactory.getNotices(vm.offset).then (res) ->
    vm.notices = res.notices
    vm.total_count = res.total_count
    total_array = []
    for i in [0..vm.total_count]
      total_array.push(i)
    vm.offset_numbers = total_array.filter (x) ->
      return x % 20 == 0

  return

angular.module 'newAccountBook'
  .controller('NoticesController', NoticesController)

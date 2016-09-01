UsersController = (AdminFactory, $uibModal) ->
  'ngInject'
  vm = this

  vm.offset = 0
  vm.clickPaginate = (offset) ->
    vm.offset = offset
    AdminFactory.getUsers(vm.offset).then (res) ->
      vm.users = res.users
      vm.total_count = res.total_count
      total_array = []
      for i in [0..vm.total_count]
        total_array.push(i)
      vm.offset_numbers = total_array.filter (x) ->
        return x % 20 == 0

  AdminFactory.getUsers(vm.offset).then (res) ->
    vm.users = res.users
    vm.total_count = res.total_count
    total_array = []
    for i in [0..vm.total_count]
      total_array.push(i)
    vm.offset_numbers = total_array.filter (x) ->
      return x % 20 == 0

  vm.message = (user_id) ->
    modalInstance = $uibModal.open(
      templateUrl: 'app/admin/modals/new_message.html'
      controller: 'NewMessageController'
      controllerAs: 'message'
      resolve: { user_id: user_id }
      backdrop: 'static'
    )
    modalInstance.result.then () ->

  return

angular.module 'newAccountBook'
  .controller 'UsersController', UsersController

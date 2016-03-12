UsersController = (AdminFactory, $modal) ->
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
    modalInstance = $modal.open(
      templateUrl: 'new-message'
      controller: 'NewMessageController'
      controllerAs: 'message'
      resolve: { user_id: user_id }
      backdrop: 'static'
    )
    modalInstance.result.then () ->
      return

  return

NewMessageController = (IndexService, AdminFactory, $modalInstance, user_id) ->
  'ngInject'
  vm = this

  vm.cancel = () ->
    $modalInstance.dismiss()

  IndexService.modal_loading = true
  AdminFactory.getUserFeedbacks(user_id).then((res) ->
    vm.feedbacks = res.feedbacks
    IndexService.modal_loading = false
  ).catch (res) ->
    IndexService.modal_loading = false

    return
  return

angular.module 'newAccountBook'
  .controller 'NewMessageController', NewMessageController
  .controller 'UsersController', UsersController

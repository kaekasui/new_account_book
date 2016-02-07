UserController = (AdminFactory, user_id) ->
  vm = this

  AdminFactory.getUser(user_id).then (res) ->
    vm.user = res
  vm.user = undefined

FeedbacksController = (AdminFactory, $modal) ->
  'ngInject'
  vm = this

  vm.offset = 0
  vm.clickPaginate = (offset) ->
    vm.offset = offset
    AdminFactory.getFeedbacks(vm.offset).then (res) ->
      vm.feedbacks = res.feedbacks
      vm.total_count = res.total_count
      total_array = []
      for i in [0..vm.total_count]
        total_array.push(i)
      vm.offset_numbers = total_array.filter (x) ->
        return x % 20 == 0

  AdminFactory.getFeedbacks(vm.offset).then (res) ->
    vm.feedbacks = res.feedbacks
    vm.total_count = res.total_count
    total_array = []
    for i in [0..vm.total_count]
      total_array.push(i)
    vm.offset_numbers = total_array.filter (x) ->
      return x % 20 == 0

  vm.user_modal = (user_id) ->
    modalInstance = $modal.open(
      templateUrl: 'user'
      controller: 'UserController'
      controllerAs: 'user'
      resolve: { user_id: user_id }
      bindToController: true
    )
    modalInstance.result.then () ->
      return

  return

angular.module 'newAccountBook'
  .controller('UserController', UserController)
  .controller('FeedbacksController', FeedbacksController)

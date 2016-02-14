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

  vm.user = (user_id) ->
    modalInstance = $modal.open(
      templateUrl: 'user'
      controller: 'UserController'
      controllerAs: 'user'
      resolve: { user_id: user_id }
    )
    modalInstance.result.then () ->
      return

  vm.check = (index) ->
    feedback = vm.feedbacks[index]
    AdminFactory.patchFeedbackCheck(feedback.id).then (res) ->
      vm.feedbacks[index].checked = res.checked

  return

UserController = (AdminFactory, user_id) ->
  'ngInject'
  vm = this

  AdminFactory.getUser(user_id).then (res) ->
    vm.user = res

  return

angular.module 'newAccountBook'
  .controller('UserController', UserController)
  .controller('FeedbacksController', FeedbacksController)

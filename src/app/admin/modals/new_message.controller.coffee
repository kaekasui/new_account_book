NewMessageController = (IndexService, AdminFactory, $modalInstance, user_id) ->
  'ngInject'
  vm = this

  vm.cancel = () ->
    $modalInstance.dismiss()

  vm.focusOn = ($event) ->
    setTimeout ( ->
      $event.currentTarget.focus()
    ), 200

  IndexService.modal_loading = true
  AdminFactory.getUserFeedbacks(user_id).then((res) ->
    vm.feedbacks = res.feedbacks
    vm.user_name = res.user_name
    IndexService.modal_loading = false
  ).catch (res) ->
    IndexService.modal_loading = false

  vm.submit = () ->
    IndexService.sending = true
    if vm.feedback_index_id
      vm.feedback_id = vm.feedbacks[vm.feedback_index_id].id
    params =
      feedback_id: vm.feedback_id
      content: vm.content
    AdminFactory.postMessage(user_id, params).then((res) ->
      IndexService.sending = false
      $modalInstance.close()
    ).catch (res) ->
      IndexService.sending = false

  return

angular.module 'newAccountBook'
  .controller 'NewMessageController', NewMessageController

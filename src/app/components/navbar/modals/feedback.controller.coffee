FeedbackController = (IndexFactory, $translate, $modalInstance, toastr, IndexService) ->
  'ngInject'
  vm = this
  vm.placeholder = $translate.instant('MESSAGES.FEEDBACK')

  IndexFactory.getCurrentUser().then((res) ->
    vm.current_user = res
  ).catch (res) ->

  vm.submit = () ->
    IndexService.sending = true
    params = {}
    if vm.current_user != undefined
      params =
        user_id: vm.current_user.id,
        content: vm.content
    else
      params =
        email: if vm.email == undefined then '' else vm.email,
        content: vm.content

    IndexFactory.postFeedback(params).then( ->
      $modalInstance.close()
      IndexService.sending = false
    ).catch (res) ->
      vm.errors = res.error_messages
      IndexService.sending = false

  vm.cancel = () ->
    $modalInstance.close()

  return

angular.module 'newAccountBook'
  .controller('FeedbackController', FeedbackController)

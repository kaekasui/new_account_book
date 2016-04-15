FeedbackController = (IndexFactory, $translate, $modalInstance, toastr) ->
  'ngInject'
  vm = this
  vm.placeholder = $translate.instant('MESSAGES.FEEDBACK')
  ga('send', 'event', 'フィードバック', 'クリック', 'モーダル表示', true)

  IndexFactory.getCurrentUser().then((res) ->
    vm.current_user = res
    return
  ).catch (res) ->
    return

  vm.submit = () ->
    vm.sending = true
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
      vm.sending = false
      return
    ).catch (res) ->
      vm.errors = res.error_messages
      vm.sending = false
      return

  vm.cancel = () ->
    $modalInstance.close()

  return

angular.module 'newAccountBook'
  .controller('FeedbackController', FeedbackController)

AdminNoticeController = ($modalInstance, AdminFactory, notice, IndexService) ->
  'ngInject'
  vm = this
  vm.notice = notice
  vm.edit_field = false

  vm.post_at = new Date(notice.post_at)
  vm.title = notice.title
  vm.content = notice.content

  vm.cancel = () ->
    $modalInstance.dismiss()

  vm.submit = () ->
    IndexService.sending = true
    params =
      post_at: vm.post_at
      title: vm.title
      content: vm.content
    AdminFactory.patchNotice(vm.notice.id, params).then((res) ->
      $modalInstance.close()
      IndexService.sending = false
    ).catch (res) ->
      IndexService.sending = false

  return

angular.module 'newAccountBook'
  .controller('AdminNoticeController', AdminNoticeController)

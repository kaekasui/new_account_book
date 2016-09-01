DestroyNoticeController = (notice_id, AdminFactory, $uibModalInstance, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    AdminFactory.deleteNotice(notice_id).then ->
      $uibModalInstance.close()
      IndexService.sending = false

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyNoticeController', DestroyNoticeController)

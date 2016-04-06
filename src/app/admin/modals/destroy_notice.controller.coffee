DestroyNoticeController = (notice_id, AdminFactory, $modalInstance) ->
  'ngInject'
  vm = this

  vm.ok = () ->
    AdminFactory.deleteNotice(notice_id).then ->
      $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('DestroyNoticeController', DestroyNoticeController)

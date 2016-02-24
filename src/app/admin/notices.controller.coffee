NoticesController = (AdminFactory, $modal, $translate, toastr) ->
  'ngInject'
  vm = this

  vm.offset = 0
  vm.clickPaginate = (offset) ->
    vm.offset = offset
    AdminFactory.getNotices(vm.offset).then (res) ->
      vm.notices = res.notices
      vm.total_count = res.total_count
      total_array = []
      for i in [0..vm.total_count]
        total_array.push(i)
      vm.offset_numbers = total_array.filter (x) ->
        return x % 20 == 0

  AdminFactory.getNotices(vm.offset).then (res) ->
    vm.notices = res.notices
    vm.total_count = res.total_count
    total_array = []
    for i in [0..vm.total_count]
      total_array.push(i)
    vm.offset_numbers = total_array.filter (x) ->
      return x % 20 == 0

  vm.newNotice = () ->
    modalInstance = $modal.open(
      templateUrl: 'new-notice'
      controller: 'AdminNoticeController'
      controllerAs: 'new_notice'
      backdrop: 'static'
    )
    modalInstance.result.then () ->
      toastr.success $translate.instant('MESSAGES.CREATE_NOTICE')
      AdminFactory.getNotices(vm.offset).then (res) ->
        vm.notices = res.notices
        vm.total_count = res.total_count
        total_array = []
        for i in [0..vm.total_count]
          total_array.push(i)
        vm.offset_numbers = total_array.filter (x) ->
          return x % 20 == 0

    return

  vm.showNotice = (index) ->
    notice = vm.notices[index]
    modalInstance = $modal.open(
      templateUrl: 'notice'
      controller: 'AdminShowNoticeController'
      controllerAs: 'notice'
      resolve: { notice: notice }
    )
    modalInstance.result.then () ->
      return

  return

AdminNoticeController = ($modalInstance, AdminFactory) ->
  'ngInject'
  vm = this
  vm.date_picker_open = true
  vm.post_at = new Date()

  vm.cancel = () ->
    $modalInstance.dismiss()

  vm.submit = () ->
    params =
      post_at: vm.post_at
      title: vm.title
      content: vm.content
    AdminFactory.postNotice(params).then (res) ->
      $modalInstance.close()

  return

AdminShowNoticeController = (notice) ->
  'ngInject'
  vm = this
  vm.notice = notice

  vm.title_text_field = false
  vm.content_text_field = false
  vm.post_at_date_field = false
  vm.post_at = new Date(notice.post_at)
  vm.title = notice.title
  vm.content = notice.content

  return

angular.module 'newAccountBook'
  .controller('AdminNoticeController', AdminNoticeController)
  .controller('AdminShowNoticeController', AdminShowNoticeController)
  .controller('NoticesController', NoticesController)

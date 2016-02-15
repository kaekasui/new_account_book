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
      controller: 'NoticeController'
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

  return

NoticeController = ($modalInstance, AdminFactory) ->
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

  vm.toggleDatePicker = (e) ->
    e.stopPropagation()
    vm.date_picker_open = !vm.date_picker_open

  return

angular.module 'newAccountBook'
  .controller('NoticeController', NoticeController)
  .controller('NoticesController', NoticesController)

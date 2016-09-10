NoticesController = (AdminFactory, $uibModal, $translate, toastr) ->
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
    modalInstance = $uibModal.open(
      templateUrl: 'app/admin/modals/new_notice.html'
      controller: 'NewNoticeController'
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

  vm.destroyNotice = (index) ->
    notice = vm.notices[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/components/modals/destroy.html'
      controller: 'DestroyNoticeController'
      controllerAs: 'confirm_destroy'
      resolve: { notice_id: notice.id }
    )
    modalInstance.result.then () ->
      AdminFactory.getNotices().then (res) ->
        vm.notices = res.notices

    return

  vm.showNotice = (index) ->
    notice = vm.notices[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/admin/modals/notice.html'
      controller: 'AdminNoticeController'
      controllerAs: 'notice'
      resolve: { notice: notice },
      backdrop: 'static'
    )
    modalInstance.result.then () ->
      toastr.success $translate.instant('MESSAGES.UPDATE_NOTICE')
      AdminFactory.getNotices(vm.offset).then (res) ->
        vm.notices = res.notices
        vm.total_count = res.total_count
        total_array = []
        for i in [0..vm.total_count]
          total_array.push(i)
        vm.offset_numbers = total_array.filter (x) ->
          return x % 20 == 0
  return

angular.module 'newAccountBook'
  .controller('NoticesController', NoticesController)

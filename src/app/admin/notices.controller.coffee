NoticesController = (AdminFactory, $modal) ->
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
      return
    return

  return

NoticeController = ($modalInstance, AdminFactory) ->
  'ngInject'
  vm = this

  vm.cancel = () ->
    $modalInstance.dismiss()

  vm.submit = () ->
    params =
      title: vm.title
      content: vm.content
    AdminFactory.postNotice(params).then (res) ->
      console.log 'success'

  return

angular.module 'newAccountBook'
  .controller('NoticeController', NoticeController)
  .controller('NoticesController', NoticesController)

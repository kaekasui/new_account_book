MypageController = (UserFactory, $modal) ->
  'ngInject'
  vm = this
  vm.offset = 0

  UserFactory.getNotices(vm.offset).then (res) ->
    vm.notices = res.notices

  vm.showNotice = (index) ->
    notice = vm.notices[index]
    modalInstance = $modal.open(
      templateUrl: 'notice'
      controller: 'NoticeController'
      controllerAs: 'notice'
      resolve: { notice: notice }
    )
    modalInstance.result.then () ->
      return

  return

NoticeController = (notice) ->
  'ngInject'
  vm = this
  vm.notice = notice

  return

angular.module 'newAccountBook'
  .controller('NoticeController', NoticeController)
  .controller('MypageController', MypageController)

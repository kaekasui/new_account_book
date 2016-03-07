MypageController = (UserFactory, $modal, IndexService) ->
  'ngInject'
  vm = this
  vm.offset = 0

  IndexService.loading = true
  UserFactory.getNotices(vm.offset).then((res) ->
    vm.notices = res.notices
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  return

angular.module 'newAccountBook'
  .controller('MypageController', MypageController)

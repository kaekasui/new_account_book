MypageController = (UserFactory, $modal) ->
  'ngInject'
  vm = this
  vm.offset = 0

  UserFactory.getNotices(vm.offset).then (res) ->
    vm.notices = res.notices

  return

angular.module 'newAccountBook'
  .controller('MypageController', MypageController)

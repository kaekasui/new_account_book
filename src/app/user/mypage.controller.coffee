MypageController = (UserFactory, IndexService) ->
  'ngInject'
  vm = this

  IndexService.loading = true
  UserFactory.getMypage().then((res) ->
    vm.notices = res.notices
    vm.messages = res.messages
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  return

angular.module 'newAccountBook'
  .controller('MypageController', MypageController)

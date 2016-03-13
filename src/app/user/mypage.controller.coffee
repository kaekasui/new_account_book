MypageController = (UserFactory, $modal, IndexService) ->
  'ngInject'
  vm = this
  vm.offset = 0

  IndexService.notice_loading = true
  UserFactory.getNotices(vm.offset).then((res) ->
    vm.notices = res.notices
    IndexService.notice_loading = false
  ).catch (res) ->
    IndexService.notice_loading = false

  IndexService.message_loading = true
  UserFactory.getMessages(vm.offset).then((res) ->
    vm.messages = res.messages
    IndexService.message_loading = false
  ).catch (res) ->
    IndexService.message_loading = false
 
  return

angular.module 'newAccountBook'
  .controller('MypageController', MypageController)

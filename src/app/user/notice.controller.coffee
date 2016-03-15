NoticeController = ($stateParams, UserFactory, IndexFactory) ->
  'ngInject'
  vm = this

  IndexFactory.getCurrentUser().then((res) ->
    vm.current_user = res
  ).catch (res) ->
    return

  UserFactory.getNotice($stateParams.id).then (res) ->
    vm.notice = res

  return

angular.module 'newAccountBook'
  .controller('NoticeController', NoticeController)

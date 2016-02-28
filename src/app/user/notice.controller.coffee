NoticeController = ($stateParams, UserFactory) ->
  'ngInject'
  vm = this

  UserFactory.getNotice($stateParams.id).then (res) ->
    vm.notice = res

  return

angular.module 'newAccountBook'
  .controller('NoticeController', NoticeController)

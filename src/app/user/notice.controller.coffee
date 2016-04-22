NoticeController = ($stateParams, UserFactory, IndexFactory, $location) ->
  'ngInject'
  vm = this

  IndexFactory.getCurrentUser().then((res) ->
    vm.current_user = res
  ).catch (res) ->
    return

  UserFactory.getNotice($stateParams.id).then (res) ->
    vm.notice = res

  vm.current_url = "http://account-book-pig.herokuapp.com/#" + $location.url() #'http://localhost:3000/#' + $location.url()

  console.log vm.current_url
  return

angular.module 'newAccountBook'
  .controller('NoticeController', NoticeController)

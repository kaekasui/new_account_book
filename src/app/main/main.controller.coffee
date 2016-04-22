MainController = ($timeout, toastr, $location, $translate, localStorageService, IndexFactory, IndexService) ->
  'ngInject'
  vm = this

  vm.slides = [
    { id: 1, image: 'assets/images/plant.jpg'},
    { id: 2, image: 'assets/images/plant.jpg'}
  ]

  IndexService.loading = true
  IndexFactory.getTop().then((res) ->
    vm.notices = res.notices
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  if $location.search()['registed'] == 'ok'
    $location.url '/login'
    toastr.success $translate.instant('MESSAGES.REGISTED')

  if $location.search()['token']
    localStorageService.set 'access_token', $location.search()['token']
    IndexFactory.getCurrentUser().then (res) ->
      IndexService.current_user = res
      toastr.success $translate.instant('MESSAGES.LOGIN')
      delete $location.search()['token']
      $location.path '/mypage'
      return

  return

angular.module 'newAccountBook'
  .controller('MainController', MainController)

HomeController = (toastr, $location, $translate, localStorageService, HomeFactory, IndexFactory, IndexService) ->
  'ngInject'
  vm = this

  vm.slides = [
    { id: 1, image: 'assets/images/plant.jpg'},
    { id: 2, image: 'assets/images/plant.jpg'}
  ]

  IndexService.loading = true
  HomeFactory.getHome().then((res) ->
    vm.notices = res.notices
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  if $location.search()['registed'] == 'ok'
    $location.url '/login'
    toastr.success $translate.instant('MESSAGES.REGISTED')

  if $location.search()['updated_email'] == 'ok'
    $location.url '/profile'
    toastr.success $translate.instant('MESSAGES.UPDATE_EMAIL')

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
  .controller('HomeController', HomeController)

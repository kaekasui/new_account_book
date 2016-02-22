MainController = ($timeout, toastr, $location, $translate, localStorageService, IndexFactory, IndexService) ->
  'ngInject'
  vm = this

  if $location.search()['registed'] == 'ok'
    $location.url('/login')
    toastr.success $translate.instant('MESSAGES.REGISTED')

  if $location.search()['token']
    localStorageService.set 'access_token', $location.search()['token']
    IndexFactory.getCurrentUser().then (res) ->
      IndexService.current_user = res
      toastr.success $translate.instant('MESSAGES.LOGIN')
      $location.path('/')
      return

  return

angular.module 'newAccountBook'
  .controller('MainController', MainController)

IndexService = () ->
  'ngInject'
  vm = this

  vm.current_user = undefined
  vm.loading = false
  vm.modal_loading = false
  vm.notice_loading = false
  vm.message_loading = false

  return

AuthInterceptor = ($q, $location) ->
  vm = this

  vm.responseError = (res) ->
    if res.status == 401
      $location.path 'login'
    $q.reject(res)

  return

angular.module 'newAccountBook'
  .service 'IndexService', IndexService
  .service 'AuthInterceptor', AuthInterceptor

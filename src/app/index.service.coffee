IndexService = () ->
  'ngInject'
  vm = this

  vm.current_user = undefined
  vm.loading = false
  vm.modal_loading = false
  vm.records_loading = false

  return

AuthInterceptor = ($q, $location) ->
  'ngInject'
  vm = this

  vm.responseError = (res) ->
    if res.status == 401
      $location.path 'login'
    if res.status == 404
      $location.path '/errors/404'
    $q.reject(res)

  return

angular.module 'newAccountBook'
  .service 'IndexService', IndexService
  .service 'AuthInterceptor', AuthInterceptor

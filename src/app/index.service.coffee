IndexService = () ->
  'ngInject'
  vm = this

  vm.current_user = undefined
  vm.loading = false
  vm.modal_loading = false
  vm.records_loading = false
  vm.sending = false

  return

AuthInterceptor = ($q, $location) ->
  'ngInject'
  vm = this

  vm.responseError = (res) ->
    if res.status == 404
      $location.path '/errors/404'
    if res.status == 403
      $location.path '/errors/403'
    if res.status == -1
      $location.path '/errors/503'
    $q.reject(res)

  return

angular.module 'newAccountBook'
  .service 'IndexService', IndexService
  .service 'AuthInterceptor', AuthInterceptor

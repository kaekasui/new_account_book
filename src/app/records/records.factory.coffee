RecordsFactory = ($location, $q, $http, localStorageService, toastr, $translate) ->
  'ngInject'
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    postRecord: (params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.post host + 'records', params, login_headers
        .success((data) ->
          toastr.success $translate.instant('MESSAGES.CREATE_RECORD')
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise
  }

angular.module 'newAccountBook'
  .factory 'RecordsFactory', RecordsFactory

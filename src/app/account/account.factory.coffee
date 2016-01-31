AccountFactory = ($location, $q, $http, localStorageService, toastr, $translate) ->
  'ngInject'
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    postSession: (params) ->
      defer = $q.defer()
      $http.post(host + 'session', params)
        .success((data) ->
          defer.resolve data
          localStorageService.set 'access_token', data.access_token
          toastr.success $translate.instant('MESSAGES.LOGIN')
          $location.path '/'
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise
  }

angular.module 'newAccountBook'
  .factory 'AccountFactory', AccountFactory

RecordsFactory = ($location, $q, $http, localStorageService, toastr, $translate) ->
  'ngInject'
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    getNewRecord: () ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'records/new', login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    getEditRecord: (record_id) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'records/' + record_id + '/edit', login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    getRecords: (params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      $http(
        method: 'GET'
        url: host + 'records'
        params: params
        headers: { Authorization: 'Token token=' + token }
      ).success((data) ->
        defer.resolve data
        return
      ).error (data) ->
        defer.reject data
        return
      return defer.promise

    getRecord: (record_id) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'records/' + record_id, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

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

    patchSettings: (params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.patch host + 'user/set_display', params, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise
  }

angular.module 'newAccountBook'
  .factory 'RecordsFactory', RecordsFactory

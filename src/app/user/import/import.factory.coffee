ImportFactory = ($location, $q, $http, localStorageService, toastr, $translate, IndexService) ->
  'ngInject'
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    postCsvFile: (json) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.post host + 'captures/import', json, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    # TODO: モーダルで再読み込みできるようにする
    getCaptures: () ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      $http(
        method: 'GET'
        url: host + 'captures'
        headers: { Authorization: 'Token token=' + token }
      ).success((data) ->
        defer.resolve data
        return
      ).error (data) ->
        defer.reject data
        return
      return defer.promise

    getCapture: (capture_id) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      $http(
        method: 'GET'
        url: host + 'captures/' + capture_id
        headers: { Authorization: 'Token token=' + token }
      ).success((data) ->
        defer.resolve data
        return
      ).error (data) ->
        defer.reject data
        return
      return defer.promise

    patchCapture: (capture_id, params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.patch host + 'captures/' + capture_id, params, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    postCaptureId: (capture_id) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.post host + 'records/import', { capture_id: capture_id }, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    deleteCapture: (capture_id) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.delete host + 'captures/' + capture_id, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise
  }

angular.module 'newAccountBook'
  .factory 'ImportFactory', ImportFactory

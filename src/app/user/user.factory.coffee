UserFactory = ($location, $q, $http, localStorageService, toastr, $translate, IndexService) ->
  'ngInject'
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    patchProfile: (params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.patch host + 'user', params, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    patchPassword: (params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.patch host + 'user/password', params, login_headers
        .success((data) ->
          defer.resolve data
          toastr.success $translate.instant('MESSAGES.UPDATE_PASSWORD')
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    getMypage: (offset) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'mypage', login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    getMessages: (offset) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'messages?offset=' + offset, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    getNotice: (notice_id) ->
      IndexService.loading = true
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'notices/' + notice_id, login_headers
        .success((data) ->
          defer.resolve data
          IndexService.loading = false
          return
        ).error (data) ->
          defer.reject data
          IndexService.loading = false
          return
      return defer.promise

    getMessage: (message_id) ->
      IndexService.loading = true
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'messages/' + message_id, login_headers
        .success((data) ->
          defer.resolve data
          IndexService.loading = false
          return
        ).error (data) ->
          defer.reject data
          IndexService.loading = false
          return
      return defer.promise

    postNewMail: () ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.post host + 'user/send_mail', '', login_headers
        .success((data) ->
          defer.resolve data
          toastr.success $translate.instant('MESSAGES.SEND_MAIL')
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

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
  }

angular.module 'newAccountBook'
  .factory 'UserFactory', UserFactory

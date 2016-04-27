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
  }


angular.module 'newAccountBook'
  .factory 'UserFactory', UserFactory

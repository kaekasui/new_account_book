UserFactory = ($location, $q, $http, localStorageService, toastr, $translate) ->
  'ngInject'
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    patchNickname: (params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      if typeof(token) != "undefined" && token != null
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

    getNotices: (offset) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      if typeof(token) != "undefined" && token != null
        login_headers = {
          headers: { Authorization: 'Token token=' + token }
        }
        $http.get host + 'notices?offset=' + offset, login_headers
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

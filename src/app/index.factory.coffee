IndexFactory = ($location, $q, localStorageService, $http, toastr, $translate) ->
  'ngInject'
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    getCurrentUser: () ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      if typeof(token) != "undefined" && token != null
        login_headers = {
          headers: { Authorization: 'Token token=' + token }
        }
        $http.get host + 'user', login_headers
          .success((data) ->
            defer.resolve data
            return
          ).error (data) ->
            defer.reject data
            return
      return defer.promise

    postFeedback: (params) ->
      defer = $q.defer()
      $http.post host + 'feedback', params
        .success((data) ->
          toastr.success $translate.instant('MESSAGES.SEND_MESSAGE')
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise
  }

angular.module 'newAccountBook'
  .factory 'IndexFactory', IndexFactory

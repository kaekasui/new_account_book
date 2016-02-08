SettingsFactory = ($location, $q, $http, localStorageService, toastr, $translate) ->
  'ngInject'
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    postCategoryRange: (params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      if typeof(token) != "undefined" && token != null
        login_headers = {
          headers: { Authorization: 'Token token=' + token }
        }
        $http.post host + 'categories/sort', params, login_headers
          .success((data) ->
            defer.resolve data
            return
          ).error (data) ->
            defer.reject data
            return
      return defer.promise

    getCategories: () ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      if typeof(token) != "undefined" && token != null
        login_headers = {
          headers: { Authorization: 'Token token=' + token }
        }
        $http.get host + 'categories', login_headers
          .success((data) ->
            defer.resolve data
            return
          ).error (data) ->
            defer.reject data
            return
      return defer.promise

    postCategory: (params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      if typeof(token) != "undefined" && token != null
        login_headers = {
          headers: { Authorization: 'Token token=' + token }
        }
        $http.post host + 'categories', params, login_headers
          .success((data) ->
            defer.resolve data
            return
          ).error (data) ->
            defer.reject data
            return
      return defer.promise

    patchCategory: (category_id, params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      if typeof(token) != "undefined" && token != null
        login_headers = {
          headers: { Authorization: 'Token token=' + token }
        }
        $http.patch host + 'categories/' + category_id, params, login_headers
          .success((data) ->
            defer.resolve data
            return
          ).error (data) ->
            defer.reject data
            return
      return defer.promise
  }

angular.module 'newAccountBook'
  .factory 'SettingsFactory', SettingsFactory
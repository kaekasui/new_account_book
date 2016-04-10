SettingsFactory = ($location, $q, $http, localStorageService, toastr, $translate, IndexService) ->
  'ngInject'
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    getCurrentUserSettings: () ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      if token != null
        login_headers = {
          headers: { Authorization: 'Token token=' + token }
        }
        $http.get host + 'user/settings', login_headers
          .success((data) ->
            defer.resolve data
            return
          ).error (data) ->
            defer.reject data
            return
      return defer.promise

    postCategoryRange: (params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
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

    deleteCategory: (category_id) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.delete host + 'categories/' + category_id, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    getBreakdowns: (category_id) ->
      IndexService.modal_loading = true
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'categories/' + category_id + '/breakdowns', login_headers
        .success((data) ->
          defer.resolve data
          IndexService.modal_loading = false
          return
        ).error (data) ->
          defer.reject data
          IndexService.modal_loading = false
          return
      return defer.promise

    postBreakdown: (category_id, params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.post host + 'categories/' + category_id + '/breakdowns', params, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    patchBreakdown: (category_id, breakdown_id, params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.patch "#{host}categories/#{category_id}/breakdowns/#{breakdown_id}", params, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    deleteBreakdown: (category_id, breakdown_id) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.delete "#{host}categories/#{category_id}/breakdowns/#{breakdown_id}", login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    getPlaces: () ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'places', login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    getCategoryPlaces: (category_id) ->
      IndexService.modal_loading = true
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'categories/' + category_id + '/places', login_headers
        .success((data) ->
          defer.resolve data
          IndexService.modal_loading = false
          return
        ).error (data) ->
          defer.reject data
          IndexService.modal_loading = false
          return
      return defer.promise

    getPlaceCategories: (place_id) ->
      IndexService.modal_loading = true
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'places/' + place_id + '/categories', login_headers
        .success((data) ->
          defer.resolve data
          IndexService.modal_loading = false
          return
        ).error (data) ->
          defer.reject data
          IndexService.modal_loading = false
          return
      return defer.promise

    postPlace: (params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.post host + 'places', params, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    patchPlace: (place_id, params) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.patch host + 'places/' + place_id, params, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    patchPlaceCategory: (place_id, category_id) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.patch host + 'places/' + place_id + '/categories/' + category_id, '', login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    deletePlace: (place_id) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.delete host + 'places/' + place_id, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    deletePlaceCategory: (place_id, category_id) ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.delete host + 'places/' + place_id + '/categories/' + category_id, login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    getTags: () ->
      defer = $q.defer()
      token = localStorageService.get('access_token')
      login_headers = {
        headers: { Authorization: 'Token token=' + token }
      }
      $http.get host + 'tags', login_headers
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    getBaseSettings: () ->

  }

angular.module 'newAccountBook'
  .factory 'SettingsFactory', SettingsFactory

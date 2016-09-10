HomeFactory = ($location, $q, $http) ->
  'ngInject'
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    getHome: ->
      defer = $q.defer()
      $http.get host + '/'
        .success((data) ->
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise
  }

angular.module 'newAccountBook'
  .factory 'HomeFactory', HomeFactory

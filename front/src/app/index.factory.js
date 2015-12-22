(function() {
  'use strict';

    angular
      .module('accountBook')
      .factory('IndexFactory', IndexFactory);

    function IndexFactory($http, $location, $q, localStorageService) {
      var host = 'http://localhost:3001/';
      //var host = '';

      return ({
        getLoginStatus: function() {
          var token = localStorageService.get('access_token');
          return typeof(token) != "undefined" && token != null;
        },
        getCurrentUser: function(id, login_headers) {
          var defer = $q.defer();
          $http.get(host + "users/#{id}", '', login_headers)
            .success(function(data, status, headers, config) {
              defer.resolve(data);
            })
          return defer.promise;
        },
        postEmailUserRegistrations: function(params) { 
          var defer = $q.defer();
          $http.post(host + 'email_user/registrations', params)
            .success(function(data, status, headers, config) {
              $location.path('/');
            })
            .error(function(data, status, headers, config) {
              if (typeof data != 'undefined') {
                defer.reject(data);
              }
            });
          return defer.promise;
        },
        postSession: function(params) {
          var defer = $q.defer();
          $http.post(host + 'session', params)
            .success(function(data, status, headers, config) {
              defer.resolve(data);
              localStorageService.set('access_token', data.access_token);
              $location.path('/');
            })
            .error(function(data, status, headers, config) {
              defer.reject(data);
            });
          return defer.promise;
        }
      });
    }
})();

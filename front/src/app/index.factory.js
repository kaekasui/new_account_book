(function() {
  'use strict';

    angular
      .module('accountBook')
      .factory('IndexFactory', IndexFactory);

    function IndexFactory($http, $location, $q) {
      //var host = 'http://localhost:3001/';
      var host = '';
      var defer = $q.defer();

      return ({
        postEmailUserRegistrations: function(params) { 
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
        }
      });
    }
})();

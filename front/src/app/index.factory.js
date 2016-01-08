(function() {
  'use strict';

    angular
      .module('accountBook')
      .factory('IndexFactory', IndexFactory);

    function IndexFactory($http, $location, $q, localStorageService, $translate, toastr) {
      var host = ($location.host() == 'localhost') ? 'http://localhost:3001/' : '';

      return ({
        getLoginStatus: function() {
          var token = localStorageService.get('access_token');
          return typeof(token) != "undefined" && token != null;
        },
        getCurrentUser: function() {
          var defer = $q.defer();
          var token = localStorageService.get('access_token');
          if (this.getLoginStatus()) {
            var login_headers = { headers: { Authorization: "Token token=" + token }};
            $http.get(host + 'user/', login_headers)
              .success(function(data) {
                defer.resolve(data);
              })
              .error(function(data) {
                defer.reject(data);
              });
          }
          return defer.promise;
        },
        postEmailUserRegistrations: function(params) { 
          var defer = $q.defer();
          $http.post(host + 'email_user/registrations', params)
            .success(function(data) {
              defer.resolve(data);
              toastr.success($translate.instant('MESSAGES.SEND_MAIL'));
              $location.path('/');
            })
            .error(function(data) {
              if (typeof data != 'undefined') {
                defer.reject(data);
              }
            });
          return defer.promise;
        },
        postSession: function(params) {
          var defer = $q.defer();
          $http.post(host + 'session', params)
            .success(function(data) {
              defer.resolve(data);
              localStorageService.set('access_token', data.access_token);
              toastr.success($translate.instant('MESSAGES.LOGIN'));
              $location.path('/');
            })
            .error(function(data) {
              defer.reject(data);
            });
          return defer.promise;
        },
        postResendEmail: function(params) {
          var defer = $q.defer();
          $http.patch(host + 'email_user/registrations/recreate', params)
            .success(function(data) {
              defer.resolve(data);
              toastr.success($translate.instant('MESSAGES.SEND_MAIL'));
              $location.path('/');
            })
            .error(function(data) {
              defer.reject(data);
            });
          return defer.promise;
        },
        postResetPassword: function(params) {
          var defer = $q.defer();
          $http.post(host + 'email_user/passwords/send_mail', params)
            .success(function(data) {
              defer.resolve(data);
              toastr.success($translate.instant('MESSAGES.SEND_MAIL'));
              $location.path('/');
            })
            .error(function(data) {
              defer.reject(data);
            });
          return defer.promise;
        }
      });
    }
})();

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
        },
        patchNewPassword: function(user_id, params) {
          var defer = $q.defer();
          $http.patch(host + 'email_user/passwords/' + user_id, params)
            .success(function(data) {
              defer.resolve(data);
              toastr.success($translate.instant('MESSAGES.UPDATE_PASSWORD'));
              $location.path('/login');
            })
            .error(function(data) {
              defer.reject(data);
            });
          return defer.promise;
        },
        getCategories: function() {
          var defer = $q.defer();
          var token = localStorageService.get('access_token');
          if (this.getLoginStatus()) {
            var login_headers = { headers: { Authorization: "Token token=" + token }};
            $http.get(host + 'categories', login_headers)
              .success(function(data) {
                defer.resolve(data);
              })
              .error(function(data) {
                defer.reject(data);
              });
          }
          return defer.promise;
        },
        getUsers: function(offset) {
          var defer = $q.defer();
          var token = localStorageService.get('access_token');
          if (this.getLoginStatus()) {
            var login_headers = { headers: { Authorization: "Token token=" + token }};
            $http.get(host + "admin/users?offset=" + offset, login_headers)
              .success(function(data) {
                defer.resolve(data);
              })
              .error(function(data) {
                defer.reject(data);
              });
          }
          return defer.promise;
        },
        getUser: function(user_id) {
          var defer = $q.defer();
          var token = localStorageService.get('access_token');
          if (this.getLoginStatus()) {
            var login_headers = { headers: { Authorization: "Token token=" + token }};
            $http.get(host + "admin/users/" + user_id, login_headers)
              .success(function(data) {
                defer.resolve(data);
              })
              .error(function(data) {
                defer.reject(data);
              });
          }
          return defer.promise;
        },
        getFeedbacks: function(offset) {
          var defer = $q.defer();
          var token = localStorageService.get('access_token');
          if (this.getLoginStatus()) {
            var login_headers = { headers: { Authorization: "Token token=" + token }};
            $http.get(host + "admin/feedbacks?offset=" + offset, login_headers)
              .success(function(data) {
                defer.resolve(data);
              })
              .error(function(data) {
                defer.reject(data);
              });
          }
          return defer.promise;
        },
        postCategoryRange: function(params) {
          var defer = $q.defer();
          $http.post(host + 'categories/sort', params)
            .success(function(data) {
              defer.resolve(data);
            })
            .error(function(data) {
              defer.reject(data);
            });
          return defer.promise;
        },
        postFeedback: function(params) {
          var defer = $q.defer();
          $http.post(host + 'feedback', params)
            .success(function(data) {
              defer.resolve(data);
            })
            .error(function(data) {
              defer.reject(data);
            });
          return defer.promise;
        }
      });
    }
})();

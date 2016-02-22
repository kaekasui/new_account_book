AccountFactory = ($location, $q, $http, localStorageService, toastr, $translate) ->
  'ngInject'
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''

  return {
    postSession: (params) ->
      defer = $q.defer()
      $http.post(host + 'session', params)
        .success((data) ->
          localStorageService.set 'access_token', data.access_token
          toastr.success $translate.instant('MESSAGES.LOGIN')
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    postEmailUserRegistration: (params) ->
      defer = $q.defer()
      $http.post(host + 'email_user/registrations', params)
        .success((data) ->
          toastr.success $translate.instant('MESSAGES.SEND_MAIL')
          $location.path 'login'
          defer.resolve data
          return
        ).error (data) ->
          if (typeof data != 'undefined')
            defer.reject data
          return
      return defer.promise

    patchResendEmail: (params) ->
      defer = $q.defer()
      $http.patch(host + 'email_user/registrations/recreate', params)
        .success((data) ->
          toastr.success $translate.instant('MESSAGES.SEND_MAIL')
          $location.path 'login'
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    postResetPassword: (params) ->
      defer = $q.defer()
      $http.post(host + 'email_user/passwords/send_mail', params)
        .success((data) ->
          toastr.success $translate.instant('MESSAGES.SEND_MAIL')
          $location.path 'login'
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise

    patchNewPassword: (user_id, params) ->
      defer = $q.defer()
      $http.patch(host + 'email_user/passwords/' + user_id, params)
        .success((data) ->
          toastr.success $translate.instant('MESSAGES.UPDATE_PASSWORD')
          $location.path 'login'
          defer.resolve data
          return
        ).error (data) ->
          defer.reject data
          return
      return defer.promise
  }

angular.module 'newAccountBook'
  .factory 'AccountFactory', AccountFactory

angular.module 'newAccountBook'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: 'app/main/main.html'
        controllerAs: 'main'
        controller: 'MainController'
      .state 'login',
        url: '/login'
        templateUrl: 'app/account/login.html'
        controllerAs: 'login'
        controller: 'LoginController'
      .state 'sign_up',
        url: '/sign_up'
        templateUrl: 'app/account/sign_up.html'
        controllerAs: 'sign_up'
        controller: 'SignUpController'
      .state 'resend_email',
        url: '/resend_email'
        templateUrl: 'app/account/resend_email.html'
        controllerAs: 'resend_email'
        controller: 'ResendEmailController'
      .state 'reset_password',
        url: '/reset_password'
        templateUrl: 'app/account/reset_password.html'
        controllerAs: 'reset_password'
        controller: 'ResetPasswordController'

    $urlRouterProvider.otherwise '/'

(function() {
  'use strict';

  angular
    .module('accountBook')
    .config(routerConfig);

  /** @ngInject */
  function routerConfig($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('admin', {
        url: '/admin',
        templateUrl: 'app/admin/admin.html',
        controller: 'AdminController',
        controllerAs: 'admin'
      })
      .state('home', {
        url: '/',
        templateUrl: 'app/main/main.html',
        controller: 'MainController',
        controllerAs: 'main'
      })
      .state('login', {
        url: '/login',
        templateUrl: 'app/account/login.html',
        controller: 'LoginController',
        controllerAs: 'login'
      })
      .state('sign_up', {
        url: '/sign_up',
        templateUrl: 'app/account/sign_up.html',
        controller: 'SignUpController',
        controllerAs: 'sign_up'
      })
      .state('reset_password', {
        url: '/reset_password',
        templateUrl: 'app/account/reset_password.html',
        controller: 'ResetPasswordController',
        controllerAs: 'reset_password'
      })
      .state('edit_password', {
        url: '/edit_password',
        templateUrl: 'app/account/edit_password.html',
        controller: 'EditPasswordController',
        controllerAs: 'edit_password'
      })
      .state('resend_email', {
        url: '/resend_email',
        templateUrl: 'app/account/resend_email.html',
        controller: 'ResendEmailController',
        controllerAs: 'resend_email'
      })
      .state('menu', {
        url: '/menu',
        templateUrl: 'app/components/menu/menu.html',
        controller: 'MenuController',
        controllerAs: 'menu'
      })
      .state('mypage', {
        url: '/mypage',
        templateUrl: 'app/user/mypage.html',
        controller: 'MypageController',
        controllerAs: 'mypage'
      })
      .state('terms', {
        url: '/terms',
        templateUrl: 'app/components/footer/terms.html',
        controller: 'TermsController',
        controllerAs: 'terms'
      });

    $urlRouterProvider.otherwise('/');
  }

})();

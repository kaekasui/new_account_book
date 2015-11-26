(function() {
  'use strict';

  angular
    .module('accountBook')
    .config(routerConfig);

  /** @ngInject */
  function routerConfig($stateProvider, $urlRouterProvider) {
    $stateProvider
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
      .state('menu', {
        url: '/menu',
        templateUrl: 'app/components/menu/menu.html',
        controller: 'MenuController',
        controllerAs: 'menu'
      });

    $urlRouterProvider.otherwise('/');
  }

})();

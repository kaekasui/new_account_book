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
        controller: 'LoginController'

    $urlRouterProvider.otherwise '/'

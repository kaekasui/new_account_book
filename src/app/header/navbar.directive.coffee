navbarDirective = () ->
  directive =
    restrict: 'E'
    templateUrl: 'app/header/navbar.html'
    controller: 'NavbarController'
    controllerAs: 'navbar'
    bindToController: true

angular.module 'newAccountBook'
  .directive('navbarDirective', navbarDirective)

navbarDirective = () ->
  NavbarController = () ->
    'ngInject'
    return

  directive =
    restrict: 'E'
    templateUrl: 'app/components/navbar/navbar.html'
    controller: NavbarController
    controllerAs: 'navbar'
    bindToController: true

angular.module 'newAccountBook'
  .directive 'navbarDirective', navbarDirective

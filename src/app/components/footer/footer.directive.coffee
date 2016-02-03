FooterController = () ->
  'ngInject'
  vm = this

footerDirective = () ->
  directive =
    restrict: 'E'
    templateUrl: 'app/components/footer/footer.html'
    controller: 'FooterController'
    controllerAs: 'footer'
    bindToController: true

angular.module 'newAccountBook'
  .controller('FooterController', FooterController)
  .directive('footerDirective', footerDirective)

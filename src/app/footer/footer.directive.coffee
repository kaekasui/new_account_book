footerDirective = () ->
  directive =
    restrict: 'E'
    templateUrl: 'app/footer/footer.html'
    bindToController: true

angular.module 'newAccountBook'
  .directive('footerDirective', footerDirective)

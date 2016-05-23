loadingDirective = () ->
  directive =
    restrict: 'E'
    scope:
      target: '@'
    templateUrl: 'app/components/loading/loading.html'
    controller: 'LoadingController'
    controllerAs: 'loading'
    bindToController: true

angular.module 'newAccountBook'
  .directive('loadingDirective', loadingDirective)

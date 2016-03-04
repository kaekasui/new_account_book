LoadingController = (IndexService, $scope) ->
  'ngInject'
  vm = this

  $scope.$watch ( ->
    IndexService.loading
  ), ->
    vm.loading = IndexService.loading

  return

loadingDirective = () ->
  directive =
    restrict: 'E'
    templateUrl: 'app/components/loading.html'
    controller: 'LoadingController'
    controllerAs: 'loading'
    bindToController: true

angular.module 'newAccountBook'
  .controller('LoadingController', LoadingController)
  .directive('loadingDirective', loadingDirective)

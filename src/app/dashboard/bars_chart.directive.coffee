barsChartDirective = () ->
  directive =
    restrict: 'E'
    scope:
      year: '='
      month: '='
    templateUrl: 'app/dashboard/bars_chart.html'
    controller: 'BarsChartController'
    controllerAs: 'bars'
    bindToController: true

angular.module 'newAccountBook'
  .directive('barsChartDirective', barsChartDirective)

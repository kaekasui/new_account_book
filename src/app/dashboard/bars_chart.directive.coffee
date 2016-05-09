barsChartDirective = (D3Factory, $parse) ->
  d3 = D3Factory.d3
  directive =
    restrict: 'E'
    replace: false
    scope:
      data: '='
      key: '@'
      valueProp: '@'
      label: '@'
    link: (scope, element) ->
      dataSet = scope.data
      w = 500
      h = 200
      # TODO: 縦横の幅を修正する
      xScale = d3.scale.linear()
        .domain([0, d3.max(dataSet)])
        .range([0, w])
        .nice()

      svg = d3.select('.daily-graph').append('svg').attr({ width: w, height: h })
      svg.selectAll('rect')
        .data(dataSet)
        .enter()
        .append('rect')
        .attr(
          x: 0
          y: (d, i) -> i * 25
          width: (d) -> xScale(d)
          height: 20
          fill: "red"
        )
      return

angular.module 'newAccountBook'
  .directive('barsChartDirective', barsChartDirective)

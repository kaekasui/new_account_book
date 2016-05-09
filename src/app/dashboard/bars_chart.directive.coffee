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
      padding = 20

      # TODO: 縦横の幅を修正する
      xScale = d3.scale.linear()
        .domain([0, d3.max(dataSet)])
        .range([padding, w - padding])
        .nice()

      svg = d3.select('.daily-graph').append('svg').attr({ width: w, height: h })

      xAxis = d3.svg.axis().scale(xScale).orient('buttom')
      svg.append('g').attr({ class: 'axis', transform: 'translate(0, 180)'}).call(xAxis)

      svg.selectAll('rect')
        .data(dataSet)
        .enter()
        .append('rect')
        .attr(
          x: padding
          y: (d, i) -> i * 25
          width: (d) -> xScale(d) - padding
          height: 20
          fill: "red"
        )
      return

angular.module 'newAccountBook'
  .directive('barsChartDirective', barsChartDirective)

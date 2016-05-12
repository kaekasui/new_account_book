barsChartDirective = (D3Factory, $parse, DashboardFactory) ->
  d3 = D3Factory.d3
  directive =
    restrict: 'E'
    replace: true
    scope:
      dailyData: '@'
      year: '='
      month: '='
      key: '@'
      valueProp: '@'
      label: '@'
    link: (scope, element) ->
      DashboardFactory.getDashboard({year: 2015, month: 5}).then (res) ->
        updated_at = res.updated_at
        dataSet = res.data
        margin = { top: 10, right: 10, left: 35, bottom: 20 }
        w = 1170 - margin.left - margin.right
        h = 300 - margin.top - margin.bottom

        from = new Date(scope.year, scope.month, 1)
        to = new Date(scope.year, scope.month + 1, 0)

        xScale = d3.time.scale()
          .domain([from, to])
          .range([margin.left, w])

        yScale = d3.scale.linear()
          .domain([0, Math.max.apply(null, dataSet.map (d) -> Math.max(d.plus, d.minus))])
          .range([h, margin.top])

        svg = d3.select('.daily-graph')
          .append('svg')
          .attr({
            width: w + margin.left + margin.right
            height: h + margin.top + margin.bottom
          })

        xAxis = d3.svg.axis().scale(xScale).orient('buttom').ticks(31).tickFormat(d3.time.format('%d日'))
        yAxis = d3.svg.axis().scale(yScale).orient('left').ticks(5)

        svg.append('g').attr({ class: 'axis', transform: 'translate(0, ' + h + ')' }).call(xAxis)
        svg.append('g').attr({ class: 'axis', transform: 'translate(' + margin.left + ', 0)'}).call(yAxis)

        svg.selectAll('rect')
          .data(dataSet)
          .enter()
          .append('rect')
          .attr(
            x: (d, i) ->
              xScale(new Date(d.date))
            y: (d) -> yScale(d.plus)
            width: 10
            height: (d) -> h - yScale(d.plus)
            fill: 'green'
          )
      return

angular.module 'newAccountBook'
  .directive('barsChartDirective', barsChartDirective)

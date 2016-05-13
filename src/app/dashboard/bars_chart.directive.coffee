barsChartDirective = (D3Factory, $parse, DashboardFactory) ->
  'ngInject'
  d3 = D3Factory.d3
  directive =
    restrict: 'E'
    scope:
      dailyData: '@'
      year: '='
      month: '='
    link: (scope, element) ->
      DashboardFactory.getDashboard({year: 2015, month: 5}).then (res) ->
        updated_at = res.updated_at
        dataSet = res.data
        margin = { top: 10, right: 10, left: 50, bottom: 20 }
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

        xAxis = d3.svg.axis().scale(xScale).orient('buttom').ticks(31).tickFormat(d3.time.format('%d'))
        yAxis = d3.svg.axis().scale(yScale).orient('left').ticks(5)

        svg.append('g')
          .attr({ class: 'axis', transform: 'translate(0, ' + h + ')' }).call(xAxis)
          .append('text')
          .attr({ x: w + margin.right, y: 20 })
          .text('(日)') # TODO: 英語ではday
        svg.append('g').attr({ class: 'axis', transform: 'translate(' + margin.left + ', 0)'}).call(yAxis)

        svg.selectAll('.plus-bar')
          .data(dataSet).enter().append('rect')
          .attr(
            class: 'plus-bar'
            x: (d) -> xScale(new Date(d.date)) - 13
            y: (d) -> yScale(d.plus)
            width: 10
            height: (d) -> h - yScale(d.plus)
            fill: '#5e7535'
          )
        svg.selectAll('.minus-bar')
          .data(dataSet).enter().append('rect')
          .attr(
            class: 'minus-bar'
            x: (d) -> xScale(new Date(d.date)) - 1
            y: (d) -> yScale(d.minus)
            width: 10
            height: (d) -> h - yScale(d.minus)
            fill: '#ac5e9f'
          )

angular.module 'newAccountBook'
  .directive('barsChartDirective', barsChartDirective)

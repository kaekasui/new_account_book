BarsChartController = (DashboardFactory, D3Factory, IndexService, $scope) ->
  'ngInject'
  vm = this

  d3 = D3Factory.d3
  vm.income = true
  vm.outgo = true

  $scope.$watch ( ->
    vm.month
  ), ->
    getAndDisplayData()

  vm.displayPaymentsBars = () ->
    vm.income = true
    vm.outgo = true
    displayData()

  vm.displayIncomeBars = () ->
    vm.income = true
    vm.outgo = false
    displayData()

  vm.displayOutgoBars = () ->
    vm.income = false
    vm.outgo = true
    displayData()

  getAndDisplayData = () ->
    DashboardFactory.getDashboard(vm.year, vm.month + 1).then (res) ->
      vm.updated_at = res.updated_at
      vm.dataSet = res.data
      displayData()
  
  displayData = () ->
    margin = { top: 10, right: 10, left: 50, bottom: 20 }
    w = 1170 - margin.left - margin.right
    h = 300 - margin.top - margin.bottom

    from = new Date(vm.year, vm.month, 1)
    to = new Date(vm.year, vm.month + 1, 0)

    xScale = d3.time.scale()
      .domain([from, to])
      .range([margin.left, w])

    yScale = d3.scale.linear()
      .domain([0, Math.max.apply(null,
        vm.dataSet.map (d) ->
          unless vm.income
            return d.minus
          unless vm.outgo
            return d.plus
          Math.max(d.plus, d.minus)
      )])
      .range([h, margin.top])

    tip = d3.tip()
      .attr('class', 'd3-tip')
      .offset([-10, 0])

    d3.select('svg').remove()
    svg = d3.select('.daily-graph')
      .append('svg')
      .attr(
        width: w + margin.left + margin.right
        height: h + margin.top + margin.bottom
      )
    svg.call(tip)

    xAxis = d3.svg.axis().scale(xScale).orient('buttom').ticks(31).tickFormat(d3.time.format('%d'))
    yAxis = d3.svg.axis().scale(yScale).orient('left').ticks(5)

    svg.append('g')
      .attr({ class: 'axis', transform: 'translate(0, ' + h + ')' }).call(xAxis)
      .append('text')
      .attr({ x: w + 17, y: 17 })
      .text('(日)') # TODO: 英語ではday

    svg.append('g').attr({ class: 'axis', transform: 'translate(' + margin.left + ', 0)'}).call(yAxis)

    if vm.income
      svg.selectAll('.plus-bar')
        .data(vm.dataSet).enter()
        .append('rect')
        .attr(
          class: 'plus-bar'
          x: (d) -> xScale(new Date(d.date)) - 13
          y: h
          width: 10
          height: 0
          fill: '#5e7535'
        )
        .on('mouseover', (d) ->
          d3.select(this).attr('style', 'fill:#9ebc6b')
          tip.html(d.plus).show()
        )
        .on('mouseout', (d) ->
          d3.select(this).attr('style', 'fill:#5e7535')
          tip.html(d.plus).hide()
        )
        .transition()
        .duration(500)
        .attr({
          y: (d) -> yScale(d.plus)
          height: (d) -> h - yScale(d.plus)
        })

    if vm.outgo
      svg.selectAll('.minus-bar')
        .data(vm.dataSet).enter().append('rect')
        .attr(
          class: 'minus-bar'
          x: (d) -> xScale(new Date(d.date)) - 1
          y: h
          width: 10
          height: 0
          fill: '#ac5e9f'
        )
        .on('mouseover', (d) ->
          d3.select(this).attr('style', 'fill:#d7b1d0')
          tip.html(d.minus).show()
        )
        .on('mouseout', (d) ->
          d3.select(this).attr('style', 'fill:#ac5e9f')
          tip.html(d.minus).hide()
        )
        .transition()
        .duration(500)
        .attr({
          y: (d) -> yScale(d.minus)
          height: (d) -> h - yScale(d.minus)
        })

  return

angular.module 'newAccountBook'
  .controller('BarsChartController', BarsChartController)

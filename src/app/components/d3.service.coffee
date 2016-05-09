D3Factory = () ->
  'ngInject'

  {d3: d3}

angular.module 'newAccountBook'
  .factory 'D3Factory', D3Factory

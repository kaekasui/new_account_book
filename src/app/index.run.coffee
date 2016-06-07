angular.module 'newAccountBook'
  .run ($log, $location) ->
    'ngInject'
    try
      angular.module 'angulartics.google.analytics'
    catch err
      console.log 'Failed to additional modules because of the AdBlock'
    hostname = $location.host()
    switch hostname
      when 'account-book-pig'
        ga('create', 'UA-74787122-2', 'auto')
      when 'account-book-pig-test'
        ga('create', 'UA-74787122-1', 'auto')
      else
        $log.debug 'localhost'
    $log.debug 'runBlock end'

angular.module('translateMock', [])
  .factory '$translateStaticFilesLoader', ($q) ->
    ->
      deferred = $q.defer()
      deferred.resolve({}) #空のJSONを返す
      deferred.promise

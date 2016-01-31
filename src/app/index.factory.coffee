IndexFactory = ($location) ->
  'ngInject'

  return {
    getCurrentUser: ->
      console.log 'current user'
      return
  }

angular.module 'newAccountBook'
  .factory 'IndexFactory', IndexFactory

ImportHistoryController = (IndexService, UserFactory) ->
  'ngInject'
  vm = this

  IndexService.loading = true
  UserFactory.getCaptures().then((res) ->
    vm.captures = res.captures
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  return

angular.module 'newAccountBook'
  .controller('ImportHistoryController', ImportHistoryController)

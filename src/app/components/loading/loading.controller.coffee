LoadingController = (IndexService, $scope) ->
  'ngInject'
  vm = this

  $scope.$watch ( ->
    IndexService.loading
  ), ->
    vm.loading = IndexService.loading

  $scope.$watch ( ->
    IndexService.modal_loading
  ), ->
    vm.modal_loading = IndexService.modal_loading

  $scope.$watch ( ->
    IndexService.message_loading
  ), ->
    vm.message_loading = IndexService.message_loading

  $scope.$watch ( ->
    IndexService.notice_loading
  ), ->
    vm.notice_loading = IndexService.notice_loading

  $scope.$watch ( ->
    IndexService.records_loading
  ), ->
    vm.records_loading = IndexService.records_loading

  return

angular.module 'newAccountBook'
  .controller('LoadingController', LoadingController)

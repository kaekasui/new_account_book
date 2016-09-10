SubmitButtonController = (IndexService, $scope) ->
  'ngInject'
  vm = this

  $scope.$watch ( ->
    IndexService.sending
  ), ->
    vm.sending = IndexService.sending

  return

angular.module 'newAccountBook'
  .controller('SubmitButtonController', SubmitButtonController)

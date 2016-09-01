NewBreakdownController = ($uibModalInstance, category_id, SettingsFactory, IndexService) ->
  'ngInject'
  vm = this

  SettingsFactory.getBreakdowns(category_id).then (res) ->
    vm.category = res.category
    vm.breakdowns = res.breakdowns

  vm.createBreakdown = () ->
    IndexService.sending = true
    params =
      name: vm.new_breakdown_name
    SettingsFactory.postBreakdown(category_id, params).then((res) ->
      $uibModalInstance.close(vm.new_breakdown_name)
      IndexService.sending = false
    ).catch (res) ->
      IndexService.sending = false
      vm.errors = res.error_messages

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('NewBreakdownController', NewBreakdownController)

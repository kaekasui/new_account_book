NewBreakdownController = ($modalInstance, category_id, SettingsFactory) ->
  'ngInject'
  vm = this

  SettingsFactory.getBreakdowns(category_id).then (res) ->
    vm.category = res.category
    vm.breakdowns = res.breakdowns

  vm.createBreakdown = () ->
    params =
      name: vm.new_breakdown_name
    SettingsFactory.postBreakdown(category_id, params).then (res) ->
      $modalInstance.close(vm.new_breakdown_name)

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('NewBreakdownController', NewBreakdownController)

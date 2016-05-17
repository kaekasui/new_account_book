BreakdownsController = (SettingsFactory, category_id, $modalInstance, $modal) ->
  'ngInject'
  vm = this

  SettingsFactory.getBreakdowns(category_id).then (res) ->
    vm.breakdowns = res.breakdowns
    vm.max_breakdown_count = res.max_breakdown_count

  vm.createBreakdown = (e) ->
    if e == undefined || e.which == 13
      params =
        name: vm.new_breakdown
      SettingsFactory.postBreakdown(category_id, params).then (res) ->
        vm.new_breakdown_field = false
        vm.new_breakdown = ''
        SettingsFactory.getBreakdowns(category_id).then (res) ->
          vm.breakdowns = res.breakdowns
    return

  vm.updateBreakdown = (index, e = undefined) ->
    breakdown = vm.breakdowns[index]
    if e == undefined || (e.which == 13 && breakdown.edit_name)
      SettingsFactory.patchBreakdown(category_id, breakdown.id, {name: breakdown.edit_name}).then () ->
        breakdown.name = breakdown.edit_name
        breakdown.edit_field = false
    return

  vm.destroyBreakdown = (index) ->
    breakdown = vm.breakdowns[index]
    modalInstance = $modal.open(
      templateUrl: 'app/components/modals/destroy.html'
      controller: 'DestroyBreakdownController'
      controllerAs: 'confirm_destroy'
      resolve:
        category_id: category_id
        breakdown_id: breakdown.id
    )
    modalInstance.result.then () ->
      SettingsFactory.getBreakdowns(category_id).then (res) ->
        vm.breakdowns = res.breakdowns
      return

  return

angular.module 'newAccountBook'
  .controller('BreakdownsController', BreakdownsController)

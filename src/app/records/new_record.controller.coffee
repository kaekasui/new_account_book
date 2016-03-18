NewRecordController = (IndexService, toastr, RecordsFactory, $scope) ->
  'ngInject'
  vm = this

  vm.published_at = new Date()

  IndexService.loading = true
  RecordsFactory.getNewRecord().then((res) ->
    vm.categories = res.categories
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  vm.submit = () ->
    vm.category_id = vm.categories[vm.category_index_id].id
    params =
      published_at: vm.published_at
      category_id: vm.category_id
      breakdown_id: vm.breakdown_id
      place_id: vm.place_id
      charge: vm.charge
    RecordsFactory.postRecord(params).then (res) ->
      vm.published_at = new Date()
      vm.category_id = ''
      vm.charge = ''
      $scope.newRecordForm.$setPristine()
      # TODO: コピーのリンクと編集のリンクを表示する
    return

  vm.selectCategory = (category_index_id) ->
    vm.breakdowns = vm.categories[category_index_id].breakdowns
    vm.places = vm.categories[category_index_id].places
    return

  return
 
angular.module 'newAccountBook'
  .controller('NewRecordController', NewRecordController)

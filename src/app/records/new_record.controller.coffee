NewRecordController = (SettingsFactory, IndexService, toastr, RecordsFactory, $scope) ->
  'ngInject'
  vm = this

  vm.published_at = new Date()

  IndexService.loading = true
  SettingsFactory.getCategories().then((res) ->
    vm.categories = res.categories
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  vm.submit = () ->
    params =
      published_at: vm.published_at
      category_id: vm.category_id
      charge: vm.charge
    RecordsFactory.postRecord(params).then (res) ->
      vm.published_at = new Date()
      vm.category_id = ''
      vm.charge = ''
      $scope.newRecordForm.$setPristine()
      # TODO: コピーのリンクと編集のリンクを表示する

    return
  return
 
angular.module 'newAccountBook'
  .controller('NewRecordController', NewRecordController)

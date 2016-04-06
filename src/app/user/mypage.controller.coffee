MypageController = (UserFactory, IndexService, $modal, RecordsFactory) ->
  'ngInject'
  vm = this

  IndexService.loading = true
  UserFactory.getMypage().then((res) ->
    vm.notices = res.notices
    vm.messages = res.messages
    vm.records = res.records
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  # モーダル
  vm.showRecord = (index) ->
    record = vm.records[index]
    modalInstance = $modal.open(
      templateUrl: 'app/records/modals/record.html'
      controller: 'EditRecordController'
      controllerAs: 'edit_record'
      resolve: { record_id: record.id }
      backdrop: 'static'
    )
    modalInstance.result.then () ->
      RecordsFactory.getRecord(record.id).then (res) ->
        vm.records[index] = res
      
    return

  return

angular.module 'newAccountBook'
  .controller('MypageController', MypageController)

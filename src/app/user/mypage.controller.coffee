MypageController = (UserFactory, IndexService, $uibModal, RecordsFactory) ->
  'ngInject'
  vm = this

  IndexService.loading = true
  UserFactory.getMypage().then((res) ->
    vm.notices = res.notices
    vm.messages = res.messages
    vm.records = res.records
    vm.user = res.user
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  # モーダル
  vm.showRecord = (index) ->
    record = vm.records[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/components/records/modals/record.html'
      controller: 'EditRecordController'
      controllerAs: 'edit_record'
      resolve: { record_id: record.id }
      backdrop: 'static'
    )
    modalInstance.result.then () ->
      RecordsFactory.getRecord(record.id).then (res) ->
        vm.records[index] = res
      
  vm.destroyRecord = (index) ->
    record = vm.records[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/components/modals/destroy.html'
      controller: 'DestroyRecordController'
      controllerAs: 'confirm_destroy'
      resolve: { record_id: record.id }
    )
    modalInstance.result.then () ->
      IndexService.loading = true
      UserFactory.getMypage().then((res) ->
        vm.notices = res.notices
        vm.messages = res.messages
        vm.records = res.records
        IndexService.loading = false
      ).catch (res) ->
        IndexService.loading = false

  return

angular.module 'newAccountBook'
  .controller('MypageController', MypageController)

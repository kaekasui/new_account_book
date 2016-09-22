ImportHistoryController = (IndexService, ImportFactory, $uibModal, toastr, $translate, RecordsFactory) ->
  'ngInject'
  vm = this

  vm.selectLineNumber = undefined

  getCaptures = () ->
    IndexService.loading = true
    ImportFactory.getCaptures().then((res) ->
      vm.captures = res.captures
      vm.user_currency = res.user_currency
      IndexService.loading = false
    ).catch (res) ->
      IndexService.loading = false

  # 「glyphicon-repeat すべて更新」ボタン
  vm.reloadCaptures = () ->
    for capture, index in vm.captures
      vm.reloadCapture(index)

  # 登録前の「glyphicon-info-sign」ボタン
  vm.showCapture = (index) ->
    capture = vm.captures[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/user/import/modals/capture.html'
      controller: 'EditCaptureController'
      controllerAs: 'modal'
      resolve:
        capture: ->
          capture: capture
          user_currency: vm.user_currency
      backdrop: 'static'
    )
    modalInstance.result.then (() ->
      ImportFactory.getCapture(capture.id).then (res) ->
        vm.captures[index] = res
    ), ->
      ImportFactory.getCapture(capture.id).then (res) ->
        vm.captures[index] = res

  # 登録後の「glyphicon-info-sign」ボタン
  vm.showRecord = (index) ->
    record_id = vm.captures[index].record_id
    modalInstance = $uibModal.open(
      templateUrl: 'app/components/records/modals/record.html'
      controller: 'EditRecordController'
      controllerAs: 'edit_record'
      resolve: { record_id: record_id }
      backdrop: 'static'
    )
    modalInstance.result.then () ->
      RecordsFactory.getRecord(record_id).then (res) ->
        vm.records[index] = res

  # 選択中のインポートデータの列
  vm.selectLine = (index) ->
    vm.selectLineNumber = index

  # 「登録」ボタン
  vm.import = (index) ->
    capture = vm.captures[index]
    ImportFactory.postCaptureId(capture.id).then (res) ->
      vm.captures[index].registered = true
      vm.captures[index].record_id = res.record_id
      toastr.success $translate.instant('MESSAGES.IMPORT_RECORD')

  # 「glyphicon-repeat」ボタン
  vm.reloadCapture = (index) ->
    capture = vm.captures[index]
    capture.loading = true
    ImportFactory.getCapture(capture.id).then (res) ->
      vm.captures[index] = res
      capture.loading = false

  # 「glyphicon-trash」リンク
  vm.destroyCapture = (index) ->
    capture = vm.captures[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/components/modals/destroy.html'
      controller: 'DestroyCaptureController'
      controllerAs: 'confirm_destroy'
      resolve: { capture_id: capture.id }
    )
    modalInstance.result.then () ->
      getCaptures()

  getCaptures()

  return

angular.module 'newAccountBook'
  .controller('ImportHistoryController', ImportHistoryController)

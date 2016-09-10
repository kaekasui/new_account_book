ImportHistoryController = (IndexService, ImportFactory, $uibModal) ->
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

  vm.selectLine = (index) ->
    vm.selectLineNumber = index

  # 「登録」ボタン
  vm.import = (index) ->
    capture = vm.captures[index]
    ImportFactory.postCaptureId(capture.id).then () ->
      vm.captures[index].registered = true

  # 「glyphicon-repeat」ボタン
  vm.reloadCapture = (index) ->
    capture = vm.captures[index]
    ImportFactory.getCapture(capture.id).then (res) ->
      vm.captures[index] = res

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

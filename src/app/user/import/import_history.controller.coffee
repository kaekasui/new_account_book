ImportHistoryController = (IndexService, UserFactory, $uibModal) ->
  'ngInject'
  vm = this

  vm.selectLineNumber = undefined

  IndexService.loading = true
  UserFactory.getCaptures().then((res) ->
    vm.captures = res.captures
    vm.user_currency = res.user_currency
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  vm.showCapture = (index) ->
    capture = vm.captures[index]
    modalInstance = $uibModal.open(
      templateUrl: 'app/user/modals/capture.html'
      controller: 'EditCaptureController'
      controllerAs: 'modal'
      resolve:
        capture: ->
          capture: capture
          user_currency: vm.user_currency
      backdrop: 'static'
    )
    modalInstance.result.then (() ->
      UserFactory.getCapture(capture.id).then (res) ->
        vm.captures[index] = res
    ), ->
      UserFactory.getCapture(capture.id).then (res) ->
        vm.captures[index] = res

  vm.selectLine = (index) ->
    vm.selectLineNumber = index

  # 「登録」ボタン
  vm.import = (index) ->
    capture = vm.captures[index]
    UserFactory.postCaptureId(capture.id).then () ->
      vm.captures[index].registered = true

  # 「glyphicon-repeat」ボタン
  vm.reloadCapture = (index) ->
    capture = vm.captures[index]
    UserFactory.getCapture(capture.id).then (res) ->
      vm.captures[index] = res

  return

angular.module 'newAccountBook'
  .controller('ImportHistoryController', ImportHistoryController)

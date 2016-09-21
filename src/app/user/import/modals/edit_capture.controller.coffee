EditCaptureController = (IndexService, ImportFactory, capture, $uibModalInstance, SettingsFactory, toastr, $translate) ->
  'ngInject'
  vm = this
  vm.capture = capture.capture
  vm.user_currency = capture.user_currency
  vm.published_at = new Date(vm.capture.published_at)
  vm.category_name = vm.capture.category_name
  vm.category = { name: vm.category_name, payments: false }
  vm.breakdown_name = vm.capture.breakdown_name
  vm.breakdown = { name: vm.breakdown_name }
  vm.place_name = vm.capture.place_name
  vm.place = { name: vm.place_name }
  vm.tags = vm.capture.tags
  vm.charge = vm.capture.charge
  vm.memo = vm.capture.memo
  capture_id = vm.capture.id

  # 履歴を取得する関数
  setCapture = () ->
    ImportFactory.getCapture(capture_id).then (res) ->
      vm.capture = res
      vm.published_at = new Date(vm.capture.published_at)
      vm.category_name = vm.capture.category_name
      vm.breakdown_name = vm.capture.breakdown_name
      vm.place_name = vm.capture.place_name
      vm.tags = vm.capture.tags
      vm.charge = vm.capture.charge
      vm.memo = vm.capture.memo

  setCapture()

  # キャンセル
  vm.cancel = () ->
    $uibModalInstance.dismiss()

  # カテゴリの追加ボタン
  vm.addCategory = () ->
    IndexService.sending = true
    params =
      barance_of_payments: vm.category.payments
      name: vm.category.name
    SettingsFactory.postCategory(params).then () ->
      setCapture()
      IndexService.sending = false

  # 内訳の追加ボタン
  vm.addBreakdown = () ->
    IndexService.sending = true
    params =
      name: vm.breakdown.name
    SettingsFactory.postBreakdown(vm.capture.category_id, params).then () ->
      setCapture()
      IndexService.sending = false

  # 内訳の追加ボタン
  vm.addPlace = () ->
    IndexService.sending = true
    params =
      name: vm.place.name
    SettingsFactory.postCategoryPlace(vm.capture.category_id, params).then () ->
      setCapture()
      IndexService.sending = false

  # 履歴情報の編集
  vm.submit = () ->
    IndexService.sending = true
    params =
      published_at: String(vm.published_at)
      category_name: vm.category_name
      breakdown_name: vm.breakdown_name
      place_name: vm.place_name
      charge: vm.charge
      memo: vm.memo
      tags: vm.tags
    ImportFactory.patchCapture(capture_id, params).then((res) ->
      $uibModalInstance.close()
      toastr.success $translate.instant('MESSAGES.UPDATE_CAPTURE')
      IndexService.sending = false
    ).catch (res) ->
      IndexService.sending = false
      vm.errors = res.error_messages

  return
 
angular.module 'newAccountBook'
  .controller('EditCaptureController', EditCaptureController)

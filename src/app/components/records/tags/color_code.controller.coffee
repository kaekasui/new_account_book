ColorCodeController = (tag, $uibModalInstance) ->
  'ngInject'
  vm = this
  vm.tag = tag
  vm.new_color_code = vm.tag.color_code

  # 「設定する」ボタン
  vm.submit = () ->
    vm.tag.color_code = vm.new_color_code
    $uibModalInstance.close()

  # 「閉じる」ボタン
  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('ColorCodeController', ColorCodeController)

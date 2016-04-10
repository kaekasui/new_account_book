ColorCodeController = (tag, $modalInstance) ->
  'ngInject'
  vm = this
  vm.tag = tag
  vm.new_color_code = vm.tag.color_code

  vm.submit = () ->
    vm.tag.color_code = vm.new_color_code
    $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('ColorCodeController', ColorCodeController)

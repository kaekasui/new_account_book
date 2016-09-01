NewPasswordController = ($uibModalInstance, UserFactory, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    params =
      current_password: vm.current_password
      password: vm.password
      password_confirmation: vm.password_confirmation
    UserFactory.patchPassword(params).then((res) ->
      IndexService.sending = false
      $uibModalInstance.close()
    ).catch (res) ->
      IndexService.sending = false
      vm.errors = res.error_messages

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  vm.clearErrors = () ->
    vm.errors = ''

  return

angular.module 'newAccountBook'
  .controller('NewPasswordController', NewPasswordController)

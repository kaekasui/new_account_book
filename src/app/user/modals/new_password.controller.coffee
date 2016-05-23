NewPasswordController = ($modalInstance, UserFactory, IndexService) ->
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
      $modalInstance.close()
    ).catch (res) ->
      vm.errors = res.error_messages
      IndexService.sending = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  vm.clearErrors = () ->
    vm.errors = ''

  return

angular.module 'newAccountBook'
  .controller('NewPasswordController', NewPasswordController)

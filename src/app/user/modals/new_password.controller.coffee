NewPasswordController = ($modalInstance, UserFactory) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    vm.sending = true
    params =
      current_password: vm.current_password
      password: vm.password
      password_confirmation: vm.password_confirmation
    UserFactory.patchPassword(params).then((res) ->
      vm.sending = false
      $modalInstance.close()
    ).catch (res) ->
      vm.errors = res.error_messages
      vm.sending = false

  vm.cancel = () ->
    $modalInstance.dismiss()

  vm.clearErrors = () ->
    vm.errors = ''

  return

angular.module 'newAccountBook'
  .controller('NewPasswordController', NewPasswordController)

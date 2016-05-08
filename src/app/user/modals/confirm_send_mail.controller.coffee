ConfirmSendNewMailController = ($modalInstance, UserFactory) ->
  'ngInject'
  vm = this

  vm.ok = () ->
    UserFactory.postNewMail().then ->
      $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('ConfirmSendNewMailController', ConfirmSendNewMailController)

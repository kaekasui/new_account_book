ProfileController = (IndexFactory, UserFactory, IndexService, $uibModal) ->
  'ngInject'
  vm = this
  vm.nickname_edit_field = false
  vm.email_edit_field = false

  IndexService.loading = true
  IndexFactory.getCurrentUser().then((res) ->
    vm.current_user = res
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  vm.cancelNewEmail = () ->
    vm.email_edit_field = false

  vm.updateNickname = (e = undefined) ->
    if e == undefined or e.which == 13
      UserFactory.patchProfile({ nickname: vm.new_nickname }).then ->
        vm.current_user.nickname = vm.new_nickname
        vm.nickname_edit_field = false
        IndexService.current_user = vm.current_user

  vm.updateNewEmail = () ->
    if vm.new_email == vm.current_user.email
      vm.email_edit_field = false
    else
      UserFactory.patchProfile({ new_email: vm.new_email }).then ->
        vm.current_user.new_email = vm.new_email
        vm.current_user.email = vm.new_email
        vm.email_edit_field = false
        IndexService.current_user = vm.current_user

  # モーダル
  vm.sendNewEmail = () ->
    modalInstance = $uibModal.open(
      templateUrl: 'app/components/modals/send_mail.html'
      controller: 'ConfirmSendNewMailController'
      controllerAs: 'modal'
    )
    return

  vm.modalNewPassword = () ->
    modalInstance = $uibModal.open(
      templateUrl: 'app/user/modals/new_password.html'
      controller: 'NewPasswordController'
      controllerAs: 'new_password'
    )
    return

  return

angular.module 'newAccountBook'
  .controller('ProfileController', ProfileController)

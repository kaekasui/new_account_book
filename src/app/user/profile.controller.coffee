ProfileController = (IndexFactory, UserFactory, IndexService, $modal) ->
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

  vm.updateNickname = () ->
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
    modalInstance = $modal.open(
      templateUrl: 'app/components/modals/send_mail.html'
      controller: 'ConfirmSendNewMailController'
      controllerAs: 'send_mail'
    )
    return

  return

angular.module 'newAccountBook'
  .controller('ProfileController', ProfileController)

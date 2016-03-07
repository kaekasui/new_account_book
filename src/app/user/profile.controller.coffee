ProfileController = (IndexFactory, UserFactory, IndexService) ->
  'ngInject'
  vm = this
  vm.nickname_edit_field = false

  IndexService.loading = true
  IndexFactory.getCurrentUser().then((res) ->
    vm.current_user = res
    IndexService.loading = false
  ).catch (res) ->
    IndexService.loading = false

  vm.updateNickname = (e) ->
    if e.which == 13 && vm.new_nickname != undefined
      UserFactory.patchNickname({ nickname: vm.new_nickname }).then ->
        vm.current_user.nickname = vm.new_nickname
        vm.nickname_edit_field = false
        IndexService.current_user = vm.current_user
    return

  return

angular.module 'newAccountBook'
  .controller('ProfileController', ProfileController)

EditPasswordController = (AccountFactory, $location, $translate, IndexService) ->
  'ngInject'
  vm = this

  vm.user_id = $location.search()['user_id']
  vm.email = $location.search()['email']
  vm.token = $location.search()['token']

  vm.submit = () ->
    IndexService.sending = true
    params = {
      password: vm.password
      password_confirmation: vm.password_confirmation
      token: vm.token
    }
    AccountFactory.patchNewPassword(vm.user_id, params).then((res) ->
    ).catch (res) ->
      IndexService.sending = false
      vm.errors = res.error_messages

  return

angular.module 'newAccountBook'
  .controller 'EditPasswordController', EditPasswordController

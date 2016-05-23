EditPasswordController = (AccountFactory, $location, $translate) ->
  'ngInject'
  vm = this

  vm.user_id = $location.search()['user_id']
  vm.email = $location.search()['email']
  vm.token = $location.search()['token']

  vm.submit = () ->
    params = {
      password: vm.password
      password_confirmation: vm.password_confirmation
      token: vm.token
    }
    AccountFactory.patchNewPassword(vm.user_id, params).catch (res) ->
      vm.errors = res.error_messages

  return

angular.module 'newAccountBook'
  .controller 'EditPasswordController', EditPasswordController

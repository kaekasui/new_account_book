EditPasswordController = (AccountFactory) ->
  'ngInject'
  vm = this

  vm.user_id = $location.search()['user_id']
  vm.email = $location.search()['email']
  vm.token = $location.search()['token']

  vm.clearErrors = () ->
    vm.errors = ''

  vm.submit = () ->
    params = {
      password: vm.password
      password_confirmation: vm.password_confirmation
      token: vm.token
    }

    AccountFactory.patchNewPassword(vm.user_id, params).catch (res) ->
      if res.error_messages == 'Not Found'
        vm.errors = [$translate.instant('MESSAGES.NOT_FOUND_EMAIL')]
      else
        vm.errors = res.error_messages
      return

  return

angular.module 'newAccountBook'
  .controller 'EditPasswordController', EditPasswordController

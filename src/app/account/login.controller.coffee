LoginController = (AccountFactory, $location) ->
  'ngInject'
  vm = this
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''
  vm.twitter_link = host + 'auth/twitter'

  vm.clearErrors = () ->
    vm.errors = ''

  vm.submit = () ->
    params = {
      email: vm.email
      password: vm.password
    }
    AccountFactory.postSession(params).catch (res) ->
      vm.errors = res.error_messages
      return

  return

angular.module 'newAccountBook'
  .controller 'LoginController', LoginController

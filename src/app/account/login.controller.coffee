LoginController = (AccountFactory, IndexFactory, IndexService, $location, toastr, $translate) ->
  'ngInject'
  vm = this
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''
  vm.twitter_link = host + 'auth/twitter'
  vm.facebook_link = host + 'auth/facebook'

  vm.clearErrors = () ->
    vm.errors = ''

  vm.submit = () ->
    vm.sending = true
    params = {
      email: vm.email
      password: vm.password
    }
    AccountFactory.postSession(params).then((res) ->
      IndexFactory.getCurrentUser().then (res) ->
        IndexService.current_user = res
        $location.path '/mypage'
        vm.sending = false
        return
    ).catch (res) ->
      vm.errors = res.error_messages
      vm.sending = false
      vm.password = ''
      return

  return

angular.module 'newAccountBook'
  .controller 'LoginController', LoginController

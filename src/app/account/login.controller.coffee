LoginController = (AccountFactory, IndexFactory, IndexService, $location, toastr, $translate) ->
  'ngInject'
  vm = this
  host = if $location.host() == 'localhost' then 'http://localhost:3001/' else ''
  vm.twitter_link = host + 'auth/twitter'
  vm.facebook_link = host + 'auth/facebook'

  vm.submit = () ->
    IndexService.sending = true
    params = {
      email: vm.email
      password: vm.password
    }
    AccountFactory.postSession(params).then((res) ->
      IndexService.current_user = res.user
      $location.path '/mypage'
      IndexService.sending = false
      return
    ).catch (res) ->
      vm.errors = res.error_messages
      vm.password = ''
      IndexService.sending = false
      return

  return

angular.module 'newAccountBook'
  .controller 'LoginController', LoginController

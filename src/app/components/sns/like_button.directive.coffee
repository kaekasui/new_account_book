LikeButtonController = () ->
  'ngInject'
  vm = this
  vm.url = 'http://account-book-pig.herokuapop.com/'

  ((d, s, id) ->
    js = undefined
    fjs = d.getElementsByTagName(s)[0]
    if d.getElementById(id)
      return
    js = d.createElement(s)
    js.id = id
    js.src = '//connect.facebook.net/ja_JP/sdk.js#xfbml=1&version=v2.5&appId=234695076873185'
    fjs.parentNode.insertBefore js, fjs
    return
  ) document, 'script', 'facebook-jssdk'

  return

likeButtonDirective = () ->
  directive =
    restrict: 'E'
    scope:
      title: '@'
    templateUrl: 'app/components/sns/like_button.html'
    controller: 'LikeButtonController'
    controllerAs: 'like'
    bindToController: true

angular.module 'newAccountBook'
  .controller('LikeButtonController', LikeButtonController)
  .directive('likeButtonDirective', likeButtonDirective)

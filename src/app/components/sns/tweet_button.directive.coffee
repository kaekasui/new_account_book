TweetButtonController = ($location) ->
  'ngInject'
  vm = this

  return

tweetButtonDirective = () ->
  directive =
    restrict: 'E'
    scope:
      title: '@'
    templateUrl: 'app/components/sns/tweet_button.html'
    controller: 'TweetButtonController'
    controllerAs: 'twitter'
    bindToController: true

angular.module 'newAccountBook'
  .controller('TweetButtonController', TweetButtonController)
  .directive('tweetButtonDirective', tweetButtonDirective)

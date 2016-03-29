LikeButtonController = () ->
  'ngInject'
  vm = this

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

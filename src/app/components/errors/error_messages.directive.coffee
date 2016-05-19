errorMessagesDirective = () ->
  directive =
    restrict: 'E'
    scope:
      errors: '='
    templateUrl: 'app/components/errors/error_messages.html'
    controller: 'ErrorMessagesController'
    controllerAs: 'msg'
    bindToController: true

angular.module 'newAccountBook'
  .directive('errorMessagesDirective', errorMessagesDirective)

submitButtonDirective = () ->
  directive =
    restrict: 'E'
    scope:
      form: '='
    templateUrl: 'app/components/submit_button/submit_button.html'
    controller: 'SubmitButtonController'
    controllerAs: 'btn'
    bindToController: true
    transclude: true

angular.module 'newAccountBook'
  .directive('submitButtonDirective', submitButtonDirective)

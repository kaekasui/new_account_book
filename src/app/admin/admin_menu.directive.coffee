AdminMenuController = () ->
  'ngInject'

adminMenuDirective = () ->
  directive =
    restrict: 'E'
    templateUrl: 'app/admin/menu.html'
    controller: 'AdminMenuController'
    controllerAs: 'menu'
    bindToController: true

angular.module 'newAccountBook'
  .controller('AdminMenuController', AdminMenuController)
  .directive('adminMenuDirective', adminMenuDirective)

UserMenuController = () ->
  'ngInject'
  vm = this

  vm.menu_image = 'assets/images/pig_footprints.gif'
  vm.isSelected = (index) ->
    return vm.selected == index

  vm.mouseEnter = (index) ->
    vm.selected = index

  vm.mouseLeave = () ->
    vm.selected = undefined

  return

userMenuDirective = () ->
  directive =
    restrict: 'E'
    templateUrl: 'app/user/menu.html'
    controller: 'UserMenuController'
    controllerAs: 'menu'
    bindToController: true

angular.module 'newAccountBook'
  .controller('UserMenuController', UserMenuController)
  .directive('userMenuDirective', userMenuDirective)

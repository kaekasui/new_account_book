AccountMenuController = () ->
  'ngInject'
  vm = this

  vm.menu_image = 'assets/images/pig_footprints.gif'
  vm.active_menu_image = 'assets/images/pig_footprints_both.gif'
  vm.isSelected = (index) ->
    return vm.selected == index

  vm.mouseEnter = (index) ->
    vm.selected = index

  vm.mouseLeave = () ->
    vm.selected = undefined

  return

accountMenuDirective = () ->
  directive =
    restrict: 'E'
    templateUrl: 'app/account/menu.html'
    controller: 'AccountMenuController'
    controllerAs: 'menu'
    bindToController: true

angular.module 'newAccountBook'
  .controller('AccountMenuController', AccountMenuController)
  .directive('accountMenuDirective', accountMenuDirective)

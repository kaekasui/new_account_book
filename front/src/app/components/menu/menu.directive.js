(function() {
  'use strict';

  angular
    .module('accountBook')
    .controller('MenuController', MenuController)
    .directive('menuDirective', menuDirective);

  function menuDirective() {
    var directive = {
      templateUrl: 'app/components/menu/menu.html',
      controller: 'MenuController',
      controllerAs: 'menu',
      bindToController: true
    };
    return directive;
  }

  function MenuController() {
    var vm = this;
    vm.menu_image = 'assets/images/pig_footprints.gif';
    vm.isSelected = function(index) {
      return vm.selected == index;
    };

    // Event
    vm.mouseEnter = function(index) {
      vm.selected = index;
    };
    vm.mouseLeave = function() {
      vm.selected = undefined;
    };
  }
  
})();

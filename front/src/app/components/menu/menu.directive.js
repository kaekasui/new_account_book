(function() {
  'use strict';

  angular
    .module('accountBook')
    .directive('menuDirective', menuDirective);

  function menuDirective() {
    var directive = {
      restrict: 'C',
      scope: {
        menuData: '='
      },
      templateUrl: 'app/components/menu/menu.html',
      controller: MenuController,
      controllerAs: 'menu',
      bindToController: true
    };

    return directive;

    function MenuController() {
      this.menus = this.menuData;
      this.menu_image = 'assets/images/pig_footprints.gif';
      this.isSelected = function(index) {
        return this.selected == index;
      };
 
      // Event
      this.mouseEnter = function(index) {
        this.selected = index;
      };
      this.mouseLeave = function() {
        this.selected = undefined;
      };
    }
  }
})();

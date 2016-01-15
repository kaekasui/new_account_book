(function() {
  'use strict';

  angular
    .module('accountBook')
    .controller('AdminMenuController', AdminMenuController)
    .directive('adminMenuDirective', adminMenuDirective);

  function adminMenuDirective() {
    var directive = {
      templateUrl: 'app/components/menu/admin_menu.html',
      controller: 'AdminMenuController',
      controllerAs: 'menu',
      bindToController: true
    };
    return directive;
  }

  function AdminMenuController() {
    var vm = this;
  }
  
})();

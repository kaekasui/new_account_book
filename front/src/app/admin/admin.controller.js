(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('AdminController', AdminController);

    function AdminController(IndexFactory) {
      var vm = this;

      IndexFactory.getUsers().then(function(res) {
        vm.users = res.users;
      });
    }

})();

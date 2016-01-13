(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('MypageController', MypageController);

    function MypageController(IndexFactory) {
      var vm = this;

      IndexFactory.getCurrentUser().then(function(res) {
        vm.current_user = res;
      })
    }

})();

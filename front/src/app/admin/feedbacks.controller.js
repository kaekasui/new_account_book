(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('UserController', UserController)
      .controller('FeedbacksController', FeedbacksController);

    function FeedbacksController(IndexFactory, $modal) {
      var vm = this;

      vm.offset = 0;
      vm.clickPaginate = function(offset) {
        vm.offset = offset;
        IndexFactory.getFeedbacks(vm.offset).then(function(res) {
          vm.feedbacks = res.feedbacks;
          vm.total_count = res.total_count;
          var total_array = [];
          for (var i=0; i<=vm.total_count; i++) {
            total_array.push(i);
          }
          vm.offset_numbers = total_array.filter(function(x) { return x % 20 === 0; });
        });
      };

      IndexFactory.getFeedbacks(vm.offset).then(function(res) {
        vm.feedbacks = res.feedbacks;
        vm.total_count = res.total_count;
          var total_array = [];
          for (var i=0; i<=vm.total_count; i++) {
            total_array.push(i);
          }
          vm.offset_numbers = total_array.filter(function(x) { return x % 20 === 0; });
      });

      vm.user = function(user_id) {
        var modalInstance = $modal.open({
          templateUrl: 'user',
          controller: 'UserController',
          controllerAs: 'user',
          resolve: { user_id: user_id }
        });

        modalInstance.result.then(function () {
        });
      };
    }

    function UserController(IndexFactory, user_id) {
      var vm = this;

      IndexFactory.getUser(user_id).then(function(res) {
        vm.user = res;
      })
  }
 
})();

(function() {
  'use strict';

    angular
      .module('accountBook')
      .controller('FeedbacksController', FeedbacksController);

    function FeedbacksController(IndexFactory) {
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
    }

})();

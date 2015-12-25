(function() {
  'use strict';

  angular
    .module('accountBook')
    .run(runBlock);

  /** @ngInject */
  function runBlock($log) {
    $log.debug('runBlock end');
  }

})();

(function() {
  'use strict';

  angular
    .module('accountBook')
    .run(runBlock);

  /** @ngInject */
  function runBlock($log, MenuFactory) {
    MenuFactory.getMenu();

    $log.debug('runBlock end');
  }

})();

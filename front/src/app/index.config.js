(function() {
  'use strict';

  angular
    .module('accountBook')
    .config(config);

  function config($translateProvider, $logProvider, toastrConfig) {
    $logProvider.debugEnabled(true);

    toastrConfig.allowHtml = true;
    toastrConfig.timeOut = 3000;
    toastrConfig.positionClass = 'toast-top-right';
    toastrConfig.preventDuplicates = false;
    toastrConfig.progressBar = false;

    // 国際化対応
    $translateProvider.useStaticFilesLoader({
      prefix: 'assets/i18n/locale-',
      suffix: '.json'
    });
    $translateProvider.preferredLanguage('ja');
    $translateProvider.fallbackLanguage('en');
    $translateProvider.useMissingTranslationHandlerLog();
    $translateProvider.useLocalStorage();
    $translateProvider.useSanitizeValueStrategy('escapeParameters');
  }

})();

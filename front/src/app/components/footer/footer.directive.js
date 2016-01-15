(function() {
  'use strict';

  angular
    .module('accountBook')
    .controller('FooterController', FooterController)
    .directive('footerDirective', footerDirective);

  function footerDirective() {
    var directive = {
      restrict: 'E',
      templateUrl: 'app/components/footer/footer.html',
      require: '^footerDirective',
      scope: {
          creationDate: '='
      },
      controller: 'FooterController',
      controllerAs: 'footer',
      bindToController: true
    };

    return directive;
  }

  function FooterController() {
    var vm = this;
  }
})();

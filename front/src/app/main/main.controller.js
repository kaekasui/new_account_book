(function() {
  (function() {
    'use strict';
    var MainController;
    MainController = function($timeout, webDevTec, toastr) {
      var activate, getWebDevTec, showToastr, vm;
      vm = this;
      activate = function() {
        getWebDevTec();
        $timeout((function() {
          vm.classAnimation = 'rubberBand';
        }), 4000);
      };
      showToastr = function() {
        toastr.info('Fork <a href="https://github.com/Swiip/generator-gulp-angular" target="_blank"><b>generator-gulp-angular</b></a>');
        vm.classAnimation = '';
      };
      getWebDevTec = function() {
        vm.awesomeThings = webDevTec.getTec();
        angular.forEach(vm.awesomeThings, function(awesomeThing) {
          awesomeThing.rank = Math.random();
        });
      };
      vm.awesomeThings = [];
      vm.classAnimation = '';
      vm.creationDate = 1447644390420;
      vm.showToastr = showToastr;
      activate();
    };
    return angular.module('accountBook').controller('MainController', MainController);
  })();

}).call(this);

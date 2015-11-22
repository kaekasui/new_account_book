do ->
  'use strict'

  LoginController = ($timeout, webDevTec, toastr) ->
    vm = this

  angular.module('accountBook').controller 'LoginController', LoginController

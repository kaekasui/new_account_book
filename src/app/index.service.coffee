IndexService = () ->
  'ngInject'
  vm = this

  vm.current_user = undefined

angular.module 'newAccountBook'
  .service 'IndexService', IndexService

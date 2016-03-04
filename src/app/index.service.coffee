IndexService = () ->
  'ngInject'
  vm = this

  vm.current_user = undefined
  vm.loading = false
  vm.modal_loading = false

angular.module 'newAccountBook'
  .service 'IndexService', IndexService

IndexService = () ->
  'ngInject'
  vm = this

  vm.current_user = undefined
  vm.loading = false
  vm.modal_loading = false
  vm.notice_loading = false
  vm.message_loading = false

angular.module 'newAccountBook'
  .service 'IndexService', IndexService

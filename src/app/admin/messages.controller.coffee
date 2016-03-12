MessagesController = (AdminFactory, $modal, $translate, toastr) ->
  'ngInject'
  vm = this

  vm.offset = 0
  vm.clickPaginate = (offset) ->
    vm.offset = offset
    AdminFactory.getMessages(vm.offset).then (res) ->
      vm.messages = res.messages
      vm.total_count = res.total_count
      total_array = []
      for i in [0..vm.total_count]
        total_array.push(i)
      vm.offset_numbers = total_array.filter (x) ->
        return x % 20 == 0

  AdminFactory.getMessages(vm.offset).then (res) ->
    vm.messages = res.messages
    vm.total_count = res.total_count
    total_array = []
    for i in [0..vm.total_count]
      total_array.push(i)
    vm.offset_numbers = total_array.filter (x) ->
      return x % 20 == 0

  vm.destroyMessage = (index) ->
    message = vm.messages[index]
    modalInstance = $modal.open(
      templateUrl: 'confirm-destroy'
      controller: 'ConfirmDestroyMessageController'
      controllerAs: 'confirm_destroy'
      resolve: { message_id: message.id }
    )
    modalInstance.result.then () ->
      AdminFactory.getMessages().then (res) ->
        vm.messages = res.messages
      return
    return

  vm.showMessage = (index) ->
    message = vm.messages[index]
    modalInstance = $modal.open(
      templateUrl: 'app/admin/modals/message.html'
      controller: 'AdminShowMessageController'
      controllerAs: 'message'
      resolve: { message: message }
    )
    modalInstance.result.then () ->
      AdminFactory.getMessages(vm.offset).then (res) ->
        vm.messages = res.messages
        vm.total_count = res.total_count
        total_array = []
        for i in [0..vm.total_count]
          total_array.push(i)
        vm.offset_numbers = total_array.filter (x) ->
          return x % 20 == 0
  return

AdminShowMessageController = ($modalInstance, AdminFactory, message, IndexService) ->
  'ngInject'
  vm = this
  vm.message = message

  return

ConfirmDestroyNoticeController = (notice_id, AdminFactory, $modalInstance) ->
  'ngInject'
  vm = this

  vm.ok = () ->
    AdminFactory.deleteNotice(notice_id).then ->
      $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('AdminShowMessageController', AdminShowMessageController)
  .controller('MessagesController', MessagesController)

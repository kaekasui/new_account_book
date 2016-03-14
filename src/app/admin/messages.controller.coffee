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
      templateUrl: 'app/components/modals/destroy.html'
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
      backdrop: 'static'
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
  vm.edit_field = false
  vm.content = message.content

  vm.cancel = () ->
    $modalInstance.dismiss()

  vm.submit = () ->
    params =
      content: vm.content
    AdminFactory.patchMessage(message.id, params).then ->
      vm.message.content = vm.content
      vm.edit_field = false

  return

ConfirmDestroyMessageController = (message_id, AdminFactory, $modalInstance) ->
  'ngInject'
  vm = this

  vm.ok = () ->
    AdminFactory.deleteMessage(message_id).then ->
      $modalInstance.close()

  vm.cancel = () ->
    $modalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('AdminShowMessageController', AdminShowMessageController)
  .controller('ConfirmDestroyMessageController', ConfirmDestroyMessageController)
  .controller('MessagesController', MessagesController)

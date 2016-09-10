MessagesController = (AdminFactory, $uibModal, $translate, toastr) ->
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
    modalInstance = $uibModal.open(
      templateUrl: 'app/components/modals/destroy.html'
      controller: 'DestroyMessageController'
      controllerAs: 'confirm_destroy'
      resolve: { message_id: message.id }
    )
    modalInstance.result.then () ->
      AdminFactory.getMessages().then (res) ->
        vm.messages = res.messages
      return
    return

  vm.send_mail = (message_id) ->
    modalInstance = $uibModal.open(
      templateUrl: 'app/components/modals/send_mail.html'
      controller: 'ConfirmSendMailController'
      controllerAs: 'modal'
      resolve: { message_id: message_id }
    )
    modalInstance.result.then () ->
    return

  vm.showMessage = (index) ->
    message = vm.messages[index]
    modalInstance = $uibModal.open(
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

AdminShowMessageController = ($uibModalInstance, AdminFactory, message, IndexService) ->
  'ngInject'
  vm = this
  vm.message = message
  vm.edit_field = false
  vm.content = message.content

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  vm.submit = () ->
    params =
      content: vm.content
    AdminFactory.patchMessage(message.id, params).then((res) ->
      vm.message.content = vm.content
      vm.edit_field = false
    ).catch (res) ->

  return

ConfirmSendMailController = (message_id, AdminFactory, $uibModalInstance, IndexService) ->
  'ngInject'
  vm = this

  vm.submit = () ->
    IndexService.sending = true
    AdminFactory.postMessageSendMail(message_id).then((res) ->
      $uibModalInstance.close()
      IndexService.sending = false
    ).catch (res) ->
      IndexService.sending = false

  vm.cancel = () ->
    $uibModalInstance.dismiss()

  return

angular.module 'newAccountBook'
  .controller('AdminShowMessageController', AdminShowMessageController)
  .controller('ConfirmSendMailController', ConfirmSendMailController)
  .controller('MessagesController', MessagesController)

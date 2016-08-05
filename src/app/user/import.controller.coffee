ImportController = ($scope, UserFactory) ->
  'ngInject'
  vm = this

  # TODO: 英語対応
  vm.sample_data = [
    ['2016-08-01', '水道光熱費', '電気代', '東京電力', '4500', '7月分', 'クレジットカード'],
    ['2016-08-03', '消耗品費', '雑貨', '', '800', '', ''],
    ['2016-08-03', '飲食費', '飲み物', 'コーヒーショップ', '450', '', 'ICカード,経費,コーヒー'],
    ['2016-08-06', '交際費', 'プレゼント', '', '6000', '山田さん誕生日', 'クレジットカード']
  ]

  vm.filter_files = (files) ->
    files.filter((element) ->
      element.completed == true || element.error == true
    )

  vm.sendData = (flow) ->
    flow.files.forEach (val) ->
      if val.completed != true && val.error != true
        vm.sending = true
        Papa.parse val.file,
          complete: (results) ->
            UserFactory.postCsvFile(results).then( ->
              val.completed = true
              vm.sending = false
            ).catch () ->
              val.error = true
              vm.sending = false
            $scope.$apply()
          error: ->
            val.error = true
            vm.sending = false

  return

angular.module 'newAccountBook'
  .controller('ImportController', ImportController)

ImportController = () ->
  'ngInject'
  vm = this

  vm.sample_data = [
    ['2016-08-01', '水道光熱費', '電気代', '東京電力', '4500', '7月分', 'クレジットカード'],
    ['2016-08-03', '消耗品費', '雑貨', '', '800', '', ''],
    ['2016-08-03', '飲食費', '飲み物', 'コーヒーショップ', '450', '', 'ICカード,経費,コーヒー'],
    ['2016-08-06', '交際費', 'プレゼント', '', '6000', '山田さん誕生日', 'クレジットカード']
  ]

  vm.readFile = () ->

  return

angular.module 'newAccountBook'
  .controller('ImportController', ImportController)

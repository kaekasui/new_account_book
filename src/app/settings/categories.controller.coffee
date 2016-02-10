CategoriesController = (SettingsFactory) ->
  'ngInject'
  vm = this
  vm.add_field = false

  SettingsFactory.getCategories().then (res) ->
    vm.categories = res.categories

  vm.addNewPanel = () ->
    vm.add_field = true

  vm.editCategory = (index) ->
    vm.categories[index].edit_field = true

  vm.createCategory = (e) ->
    if e.which == 13
      SettingsFactory.postCategory({name: vm.new_category_name}).then () ->
        SettingsFactory.getCategories().then (res) ->
          vm.categories = res.categories
        vm.new_category_name = ''
        vm.add_field = false

  vm.updateCategory = (e, index) ->
    category = vm.categories[index]
    if (e.which == 13 && category.edit_name)
      SettingsFactory.patchCategory(category.id, {name: category.edit_name}).then () ->
        category.name = category.edit_name
        category.edit_field = false

  vm.destroyCategory = (index) ->
    category = vm.categories[index]

  vm.sortable =
    update: (e, ui) ->
      if (!ui.item.sortable.model)
        ui.item.sortable.cancel()
      else
        vm.category_range = []
        for key in vm.categories
          vm.category_range.push(key.id)
          SettingsFactory.postCategoryRange({sequence: vm.category_range})
      return
    axis: ''

  return

angular.module 'newAccountBook'
  .controller 'CategoriesController', CategoriesController

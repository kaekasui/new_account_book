class AddBaranceOfPaymentsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :barance_of_payments, :boolean
  end
end

class AddAmountToMonthlyCounts < ActiveRecord::Migration
  def change
    add_column :monthly_counts, :amount, :integer
  end
end

class RenameTableFromAnswersToMessages < ActiveRecord::Migration
  def change
    rename_table :answers, :messages
  end
end

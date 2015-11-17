class AddTypeToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :type, :string, after: :content
  end
end

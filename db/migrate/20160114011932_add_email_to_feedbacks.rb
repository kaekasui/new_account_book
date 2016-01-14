class AddEmailToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :email, :string, after: :user_id
  end
end

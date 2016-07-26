# frozen_string_literal: true
class Record::Generator
  include ActiveModel::Model

  def initialize(user: nil, record_params: nil, tags_params: nil)
    @user = user
    @record_params = record_params
    @tags_params = tags_params
  end

  def save
    record = @user.records.new(@record_params)
    if record.save
      record.create_or_update_tags(@tags_params)
    else
      errors[:base] << record.errors.full_messages.join(',')
      false
    end
  end
end

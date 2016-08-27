# frozen_string_literal: true
class Record::Generator
  include ActiveModel::Model

  def initialize(user: nil, record_params: nil, tags_params: nil, capture: nil)
    @user = user
    @record_params = record_params
    @tags_params = tags_params
    @capture = capture
  end

  def build
    @record_params = {
      published_at: @capture.published_at,
      category_id: @capture.category.try(:id),
      breakdown_id: @capture.breakdown.try(:id),
      place_id: @capture.place.try(:id),
      charge: @capture.charge,
      memo: @capture.memo
    }
    @tags_params = @capture.tags.split(',').map { |n| { name: n } }
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

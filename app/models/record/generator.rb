# frozen_string_literal: true
class Record::Generator
  include ActiveModel::Model

  attr_accessor :id

  def initialize(user: nil, record_params: nil,
                 tags_params: nil, capture_id: nil)
    @user = user
    @record_params = record_params
    @tags_params = tags_params
    @capture_id = capture_id
  end

  def build
    @capture = @user.captures.find(@capture_id)
    @record_params = {
      published_at: @capture.published_at, memo: @capture.memo,
      category_id: @capture.category_id, breakdown_id: @capture.breakdown_id,
      place_id: @capture.place_id, charge: @capture.charge || 0
    }
    @tags_params = @capture.tags.split(',').map do |n|
      { id: @user.tags.find_by(name: n).try(:id), name: n }
    end if @capture.tags
  end

  def save
    record = @user.records.new(@record_params)
    if record.save
      @capture.destroy if @capture
      record.create_or_update_tags(@tags_params)
      @id = record.id
    else
      errors[:base] << record.errors.full_messages.join(',')
      false
    end
  end
end

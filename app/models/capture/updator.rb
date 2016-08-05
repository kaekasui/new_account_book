# frozen_string_literal: true
class Capture::Updator
  include ActiveModel::Model

  def initialize(user: nil, lines: {})
    @user = user
    @lines = lines
  end

  def import
    @lines.each do |published_at, category_name, breakdown_name, place_name, charge, memo, *tags|
      capture = @user.captures.new(validate_check: true, published_at: published_at, category_name: category_name,
                                   breakdown_name: breakdown_name, place_name: place_name, charge: charge, memo: memo, tags: tags.join(','))
      capture.valid?
      capture.comment = capture.errors.full_messages if capture.errors.any?
      capture.validate_check = false
      capture.save
    end
    true
  end
end

# frozen_string_literal: true
class Capture::Updator
  include ActiveModel::Model

  def initialize(user: nil, lines: {})
    @user = user
    @lines = lines
  end

  def import
    @lines.each do |line|
      capture = @user.captures.new(validate_check: true, published_at: line[0],
                                   category_name: line[1], place_name: line[3],
                                   breakdown_name: line[2], charge: line[4],
                                   memo: line[5], tags: line[6..-1])
      capture.comment = capture.errors.full_messages unless capture.valid?
      capture.validate_check = false
      return false unless capture.save
    end
    true
  end
end

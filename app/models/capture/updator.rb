# frozen_string_literal: true
class Capture::Updator
  include ActiveModel::Model

  def initialize(user: nil, lines: [])
    @user = user
    @lines = lines
  end

  def import
    @lines.each do |line|
      capture = @user.captures.new(published_at: line[0], memo: line[5],
                                   category_name: line[1], place_name: line[3],
                                   breakdown_name: line[2], charge: line[4],
                                   tags: line[6..-1].try(:join, ','))
      capture.comment =
        capture.errors.full_messages.join(',') unless capture.valid?
      return false unless capture.save(validate: false)
    end
    true
  end
end

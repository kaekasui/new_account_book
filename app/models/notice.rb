class Notice < ActiveRecord::Base
  validates :title,
            presence: true,
            length: { maximum: Settings.notice.title.maximum_length }
end

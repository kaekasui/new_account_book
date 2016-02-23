class Notice < ActiveRecord::Base
  validates :title,
            presence: true,
            length: { maximum: Settings.notice.title.maximum_length }

  scope :published, -> { where('post_at <= ?', Time.zone.today) }
end

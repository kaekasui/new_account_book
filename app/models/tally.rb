class Tally < ActiveRecord::Base
  belongs_to :user
  serialize :list, JSON

  attr_accessor :plus_count, :minus_count

  def update_list
    # TODO: 集計する
    self.list = [
      {
        date: Date.new(2016, 5, 5),
        plus: 400,
        minus: 800
      }
    ]
    save
  end
end

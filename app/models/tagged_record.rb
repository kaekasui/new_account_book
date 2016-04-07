class TaggedRecord < ActiveRecord::Base
  belongs_to :tag
  belongs_to :record
end

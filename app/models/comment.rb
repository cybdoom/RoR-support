class Comment < ActiveRecord::Base
  belongs_to :ticket

  validates :text, presence: true, length: { maximum: 512 }
end

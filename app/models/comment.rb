class Comment < ActiveRecord::Base
  belongs_to :ticket

  validates :text, presence: true, length: { maximum: 512 }
  validates :order, presence: true, numericality: { greater_than_or_equal_to: 0 }
end

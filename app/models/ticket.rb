class Ticket < ActiveRecord::Base
  include Tokenable

  belongs_to :user
  has_many :comments

  scope :unassigned, -> { where(user_id: nil) }
  scope :opened, -> { where("status = 0 or status = 1") }
  scope :frozen, -> { where(status: 2) }
  scope :closed, -> { where("status = 3 or status = 4") }

  # Both of belows can be moved to separate entities if needs to be managed
  DEPARTMENTS = ['some department', 'second department', 'other department']
  STATUSES = ['Waiting for Staff Response', 'Waiting for Customer', 'On Hold', 'Cancelled', 'Completed']

  validates :customer_name, presence: true, length: { minimum: 2, maximum: 64 }
  validates :customer_email, presence: true, email: true
  validates :department, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: DEPARTMENTS.size }
  validates :subject, presence: true, length: { minimum: 2, maximum: 64 }
  validates :description, presence: true, length: { minimum: 3, maximum: 1024 }
  validates :status, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: STATUSES.size }

  class << self
    def search_by_key key
      where("subject LIKE ? OR description LIKE ? OR department LIKE ? OR customer_name LIKE ?", *(["%#{key}%"]*4))
    end
  end

end

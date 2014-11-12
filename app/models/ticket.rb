class Ticket < ActiveRecord::Base
  include Tokenable

  belongs_to :user

  DEPARTMENTS = ['some department', 'second department', 'other department']
  STATUSES = ['Waiting for Staff Response', 'Waiting for Customer', 'On Hold', 'Cancelled', 'Completed']
  STATUS_ICONS = %w(fa-wrench fa-reply fa-clock-o fa-trash fa-check-circle-o)

  validates :customer_name, presence: true, length: { minimum: 2, maximum: 64 }
  validates :customer_email, presence: true, email: true
  validates :department, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: DEPARTMENTS.size }
  validates :subject, presence: true, length: { minimum: 2, maximum: 64 }
  validates :description, presence: true, length: { minimum: 3, maximum: 1024 }
  validates :status, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: STATUSES.size }

  def department_name
    DEPARTMENTS[self.department]
  end

  def status_name
    STATUSES[self.status]
  end

  def status_icon_class
    STATUS_ICONS[self.status]
  end
end

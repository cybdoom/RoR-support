class User < ActiveRecord::Base
  has_many :tickets

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end

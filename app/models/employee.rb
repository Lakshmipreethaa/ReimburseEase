class Employee < ApplicationRecord
  belongs_to :department
  belongs_to :designation
  has_many :bills
  validates_presence_of :first_name, :last_name, :email
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end

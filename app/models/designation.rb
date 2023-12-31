class Designation < ApplicationRecord
  has_many :employees
  validates_uniqueness_of :name, case_sensitive: false
  validates_presence_of :name
end

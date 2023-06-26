class Bill < ApplicationRecord
  belongs_to :employee
  enum bill_type: [:travel, :medicare, :insurance, :food]
  validates_presence_of :amount, :bill_type
end

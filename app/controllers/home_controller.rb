class HomeController < ApplicationController
  before_action :set_topbar_data

  def index
    @bills = Bill.order(created_at: :desc).limit(5)
    @departments = Department.all
    @designations = Designation.all
    @employees = Employee.all
  end

  private
  
  def set_topbar_data
    @total_bills = Bill.all.count
    amount = 0
    Bill.all.each do |a|
      amount = amount + a.amount
    end
    @total_amount = amount
    @total_employees = Employee.all.count
  end
end

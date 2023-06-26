class HomeController < ApplicationController
  def index
    @bills = Bill.order(created_at: :desc).limit(5)
    @departments = Department.all
    @designations = Designation.all
    @employees = Employee.all
  end
end

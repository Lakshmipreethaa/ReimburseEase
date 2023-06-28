class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]
  before_action :set_topbar_data
  before_action :set_other_values, only: :edit

  def index
    @employees = Employee.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:success] = "Employee has been created successfully"
      redirect_to employees_path
    else
      flash[:danger] = "Error." + ' ' + @employee.errors.full_messages.join(", ")
      redirect_to employees_path
    end
  end

  def update
    if @employee.update(employee_params)
      flash[:success] = "Employee has been updated successfully"
      redirect_to employees_path
    else
      flash[:danger] = "Error" + ' ' + @employee.errors.full_messages.join(", ")
      redirect_to employees_path
    end
  end

  def destroy
    employee_bill = Bill.where(employee_id: @employee.id).destroy_all
    if @employee.destroy && employee_bill
      flash[:success] = "Employee has been deleted successfully"
      redirect_to employees_path
    else
      flash[:danger] = "Error." + ' ' + @employee.errors.full_messages.join(", ")
      redirect_to employees_path
    end
  end

  private
  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :department_id, :designation_id)
  end

  def set_topbar_data
    @total_bills = Bill.all.count
    amount = 0
    Bill.all.each do |a|
      amount = amount + a.amount
    end
    @total_amount = amount
    @total_employees = Employee.all.count
  end

  def set_other_values
    @departments = Department.all
    @designations = Designation.all
  end
end

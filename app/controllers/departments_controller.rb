class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[ show edit update destroy ]
  before_action :set_topbar_data

  def index
    @departments = Department.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @department = Department.new
  end

  def edit
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      flash[:success] = "Department created successfully"
    else
      flash[:danger] = "Error," + ' ' + @department.errors.full_messages.join(", ")
    end
  end

  def update
    if @department.update(department_params)
      flash[:success] = "Department updated successfully"
      render json: { success: true, flash_message: flash[:success] }
    else
      flash[:danger] = "Error." +  ' ' + @department.errors.full_messages.join(", ")
      render json: { success: false, flash_message: flash.now[:danger] }
    end
  end

  def destroy
    employee_count = @department.employees.count
    if employee_count.zero?
      @department.destroy
      flash[:success] = "Department deleted successfully"
      redirect_to departments_path
    else
      flash[:danger] = "Cannot delete Department. There are #{employee_count} employees associated with it."
      redirect_to departments_path
    end
  end

  private
  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name)
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
end

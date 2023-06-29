class DesignationsController < ApplicationController
  before_action :set_designation, only: %i[ show edit update destroy ]
  before_action :set_topbar_data

  def index
    @designations = Designation.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @designation = Designation.new
  end

  def edit
  end

  def create
    @designation = Designation.new(designation_params)
    if @designation.save
      flash[:success] = "Designation created successfully"
    else
      flash[:danger] = "Error." + ' ' + @designation.errors.full_messages.join(", ")
    end
  end

  def update
    if @designation.update(designation_params)
      flash[:success] = "Designation updated successfully"
      render json: { success: true, flash_message: flash[:success] }
    else
      flash[:danger] = "Error." + ' ' + @designation.errors.full_messages.join(", ")
      render json: { success: false, flash_message: flash.now[:danger] }
    end
  end

  def destroy
    employee_count = @designation.employees.count
    if employee_count.zero? && @designation.destroy
      flash[:success] = "Designation updated successfully"
      redirect_to designations_path
    else
      flash[:danger] = "Cannot delete Designation. There are #{employee_count} employees associated with it."
      redirect_to designations_path
    end
  end

  private
  def set_designation
    p params[:id]
    @designation = Designation.find(params[:id])
  end

  def designation_params
    params.require(:designation).permit(:name)
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

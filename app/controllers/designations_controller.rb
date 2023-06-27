class DesignationsController < ApplicationController
  before_action :set_designation, only: %i[ show edit update destroy ]
  before_action :set_topbar_data

  def index
    @designations = Designation.all
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

    respond_to do |format|
      if @designation.save
        format.html { redirect_to designation_url(@designation), notice: "Designation was successfully created." }
        format.json { render :show, status: :created, location: @designation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @designation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @designation.update(designation_params)
      redirect_to designations_path
    else
      redirect_to designations_path
    end
  end

  def destroy
    employee_count = @designation.employees.count
    if employee_count.zero?
      @designation.destroy
      flash[:notice] = "Designation deleted successfully"
    else
      flash[:alert] = "Cannot delete Designation. There are #{employee_count} employees associated with it."
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

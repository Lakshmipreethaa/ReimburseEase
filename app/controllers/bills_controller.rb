class BillsController < ApplicationController
  before_action :set_bill, only: %i[ show edit update destroy ]
  before_action :set_topbar_data

  def index
    @bills = Bill.all
  end

  def show
  end

  def new
    @bill = Bill.new
  end

  def edit
    @employees = Employee.all
  end

  def create
    @bill = Bill.new(bill_params)
    if @bill.save
      flash[:success] = 'Bill Created Successfully'
      redirect_to bills_path
    else
      flash[:error] = 'Error in creating Bill'
      redirect_to bills_path
    end
  end

  def update
    @employees = Employee.all
    p bill_params
    if @bill.update(bill_params)
      redirect_to bills_path
    else
      redirect_to bills_path
    end
  end

  def destroy
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to bills_url, notice: "Bill was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_bill
    @bill = Bill.find(params[:id])
  end

  def bill_params
    params.require(:bill).permit(:amount, :employee_id, :bill_type)
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

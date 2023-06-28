class BillsController < ApplicationController
  before_action :set_bill, only: %i[ show edit update destroy ]
  before_action :set_topbar_data

  def index
    @bills = Bill.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
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
      flash[:danger] = 'Error.' + ' ' + @bill.errors.full_messages.join(", ")
      redirect_to bills_path
    end
  end

  def update
    @employees = Employee.all
    p bill_params
    if @bill.update(bill_params)
      flash[:success] = 'Bill updated Successfully'
      redirect_to bills_path
    else
      flash[:danger] = 'Error.' + ' ' +@bill.errors.full_messages.join(", ")
      redirect_to bills_path
    end
  end

  def destroy
    if @bill.destroy
      flash[:success] = 'Bill deleted Successfully'
      redirect_to bills_path
    else
      flash[:danger] = 'Error.' + ' ' + @bill.errors.full_messages.join(", ")
      redirect_to bills_path
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

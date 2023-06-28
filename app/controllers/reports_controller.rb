class ReportsController < ApplicationController
  before_action :set_topbar_data

  def index
    @item_dataset = [['Bill Type', 'Amount']]
    item_based_dataset
    @department_dataset = [['Department', 'Amount']]
    department_based_dataset
    @monthly_dataset = monthly_reports_dataset
    p @monthly_dataset
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

  def item_based_dataset
    bills_data = Bill.group(:bill_type).sum(:amount)
    bills_data.each do |bill_type, amount|
      @item_dataset << [bill_type.to_s.capitalize, amount.to_f]
    end
    @item_dataset
  end

  def department_based_dataset
    bills_data = Bill.includes(employee: :department).pluck('departments.name', :amount)
    department_wise_amount = bills_data.group_by(&:first).transform_values { |data| data.sum(&:second) }
    department_wise_amount.each do |department_name, amount|
      @department_dataset << [department_name.to_s, amount.to_f]
    end
    @department_dataset
  end

  def monthly_reports_dataset
    dataset = []
    (1..12).each do |month|
      amounts = Bill.where("strftime('%m', created_at) = ?", '%02d' % month).group(:bill_type).sum(:amount).transform_values(&:to_f)
      month_data = [month]
      month_data += Bill.bill_types.keys.map { |bill_type| amounts[bill_type] || 0 }
      dataset << month_data
    end
    dataset
  end
end

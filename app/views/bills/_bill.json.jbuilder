json.extract! bill, :id, :amount, :employee_id, :type, :created_at, :updated_at
json.url bill_url(bill, format: :json)

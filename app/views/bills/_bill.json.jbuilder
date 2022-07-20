json.extract! bill, :id, :staff_id, :user_id, :discount, :total_price, :actual_price, :created_at, :updated_at
json.url bill_url(bill, format: :json)

json.extract! staff, :id, :name, :email, :password, :role, :created_at, :updated_at
json.url staff_url(staff, format: :json)

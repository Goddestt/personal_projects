class Current < ActiveSupport::CurrentAttributes
  #save current user/staff when running
  attribute :user
  attribute :staff
end

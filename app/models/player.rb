class Player < ApplicationRecord

  #default to arbitrary pattern of first and last name
  def name_brief
    "#{first_name} #{last_name}"
  end
end

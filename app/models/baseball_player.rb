class BaseballPlayer < Player
  def name_brief
    "#{first_name[0]}. #{last_name[0]}."
  end
end
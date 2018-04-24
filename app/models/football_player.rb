class FootballPlayer < Player

  def name_brief
    "#{first_name[0]}. #{last_name}"
  end
end
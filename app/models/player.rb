class Player < ApplicationRecord

  #default to arbitrary pattern of first and last name
  def name_brief
    "#{first_name} #{last_name}"
  end

  def self.import_players!(data_source, types)
    Player.transaction do
      types.each do |type|
        data_source.fetch({type: type}).each do |player_json|
          Player.create({type: "#{type.titleize}Player", first_name: player_json["firstname"], last_name: player_json["lastname"]}.merge(player_json.slice("age", "position")))
        end
      end
    end
  end
end
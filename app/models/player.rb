class Player < ApplicationRecord

  ALLOWED_TYPES = [
    "baseball",
    "basketball",
    "football"
  ]

  after_commit do
    #pretty naive way to invalidate the cache, probably could make this more sophisticated
    Rails.cache.delete("#{self.type}-#{self.position}-avg-age")
  end

  #default to arbitrary pattern of first and last name
  def name_brief
    "#{first_name} #{last_name}"
  end

  def self.import_players!(data_source, types)
    Player.transaction do
      types.each do |type|
        data_source.fetch({type: type}).collect do |player_json|
          Player.create({type: "#{type.titleize}Player", first_name: player_json["firstname"], last_name: player_json["lastname"]}.merge(player_json.slice("age", "position")))
        end
      end
    end
  end

  def self.allowed_type?(type)
    ALLOWED_TYPES.include?(type)
  end

  def self.average_position_age(type, position, force_update=false)
    return 0 if type.blank? || position.blank?

    Rails.cache.fetch("#{type}-#{position}-avg-age", force: force_update) do
      ages = where(type: type, position: position).where.not(age: nil).pluck(:age)

      return 0 unless ages.any?

      ages.inject(0) { |sum, x| sum += x } / ages.size.to_f
    end
  end

  def average_position_age_diff
    return nil unless age.present?

    age - self.class.average_position_age(self.type, self.position)
  end
end
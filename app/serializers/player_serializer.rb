class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :position, :age, :name_brief, :average_position_age_diff
end
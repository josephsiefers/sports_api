class RemoveNameBriefFromPlayers < ActiveRecord::Migration[5.1]
  def change
    remove_column :players, :name_brief
  end
end

class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name_brief
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :age

      t.timestamps
    end
  end
end

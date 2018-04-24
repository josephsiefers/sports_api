class AddTypeToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :type, :string
  end
end

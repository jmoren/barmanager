class AddDoubtToClient < ActiveRecord::Migration
  def change
    add_column :clients, :doubt, :float, default: 0
  end
end

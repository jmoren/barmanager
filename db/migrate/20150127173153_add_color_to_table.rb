class AddColorToTable < ActiveRecord::Migration
  def change
    add_column    :tables, :color, :string, default: ""
  end
end

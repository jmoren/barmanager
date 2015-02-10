class AddPersonalToExtractions < ActiveRecord::Migration
  def change
    add_column :extractions, :personal, :boolean, default: false
  end
end

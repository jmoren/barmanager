class AddTimestampsToExtraction < ActiveRecord::Migration
  def change
    add_column :extractions, :created_at, :datetime
    add_column :extractions, :updated_at, :datetime
  end
end

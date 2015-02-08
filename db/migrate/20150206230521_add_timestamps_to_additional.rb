class AddTimestampsToAdditional < ActiveRecord::Migration
  def change
    add_column :additionals, :created_at, :datetime
    add_column :additionals, :updated_at, :datetime
  end
end

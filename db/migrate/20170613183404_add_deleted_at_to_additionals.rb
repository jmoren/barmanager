class AddDeletedAtToAdditionals < ActiveRecord::Migration
  def change
    add_reference :additionals, :cancel_reason, index: true, foreign_key: true
    add_column :additionals, :deleted_at, :datetime
    add_index :additionals, :deleted_at
  end
end

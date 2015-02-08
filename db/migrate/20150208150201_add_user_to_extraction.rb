class AddUserToExtraction < ActiveRecord::Migration
  def change
    add_reference :extractions, :user, index: true
  end
end

class Expense < ActiveRecord::Base
  belongs_to :shift_or_user, polymorphic: true
  belongs_to :supplier

  validates :description, :amount, :shift_or_user_id, presence: true

end

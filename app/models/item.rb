class Item < ActiveRecord::Base
  belongs_to :category

  validates :description, :price, :stock, :category, presence: true
  validates :description, uniqueness: { scope: :category_id }
end

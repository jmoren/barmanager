class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :items, class_name: 'Item', dependent: :nullify
end

class Promotion < ActiveRecord::Base
  has_many :promotion_items, dependent: :destroy
end

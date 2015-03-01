class Item < ActiveRecord::Base
  belongs_to :category

  validates :description, :code, :day_price, :night_price, :category_id, presence: true
  validates :day_price, :night_price, numericality: { greater_than: 0 }
  validates :code, uniqueness: true

  scope :favourites, -> { where(favourite: true) }

  scope :by_category, -> (id) { where(category_id: id)}

  def price
    time = Time.now.hour
    if time >= 8 && time < 18
      self.day_price
    else
      self.night_price
    end
  end
end

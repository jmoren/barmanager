class Promotion < ActiveRecord::Base
  has_many :promotion_items, dependent: :destroy

  def price
    time = Time.now
    if time > "18:00" || time < "06:00"
      self.night_price
    else
      self.day_price
    end
  end
end

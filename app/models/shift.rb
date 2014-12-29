class Shift < ActiveRecord::Base
  has_many :tickets

  def is_open?
    !self.close.nil?
  end
end

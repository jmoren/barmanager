class Extraction < ActiveRecord::Base
  belongs_to :user
  belongs_to :shift
end
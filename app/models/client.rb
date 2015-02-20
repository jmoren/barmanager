class Client < ActiveRecord::Base
  has_many :tickets, dependent: :destroy
  has_many :ticket_payments

end

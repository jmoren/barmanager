class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :validatable,
         :authentication_keys => [:login]

  has_many :shifts
  has_many :expenses, as: :shift_or_user

  def total_expenses(date)
    expenses.where(date: date).sum(:amount)
  end

  attr_accessor :login

  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :validatable,
         :authentication_keys => [:login]

  has_many :shifts
  has_many :expenses, as: :shift_or_user
  has_many :extractions

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

  def monthly_extractions(date)
    extractions.where("created_at between ? and ?", date.beginning_of_month, date.end_of_month)
  end

  def monthly_expenses(date)
    expenses.where("date between ? and ?", date.beginning_of_month, date.end_of_month)
  end

  def is_admin?
    role.downcase == "admin"
  end

  def is_manager?
    role.downcase == "manager"
  end

  def is_cooker?
    role.downcase == "cooker"
  end
end

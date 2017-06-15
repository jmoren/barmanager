class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_admin?
      can :manage, :all
    elsif user.is_manager?
      can :manage, :all
      cannot :manage, :statistics
      cannot :manage, User
    elsif user.is_cooker?
      cannot :manage, :all
      can :index, :kitchen
      can :deliver, ItemTicket
      can :deliver, PromotionTicket
    else
      can :index, Promotion
      can :index, Item
      can :index, Category
      can :manage, Ticket
      can [:read, :open, :close], Table
      can [:close], Shift, user_id: user.id
      can [:create, :index, :show], Shift
    end
  end
end

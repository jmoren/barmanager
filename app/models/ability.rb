class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      cannot :manage, User
      cannot :read, Shift
      can :update, Table
      can :manage, ItemTicket
      can :manage, PromotionTicket
      can :manage, Additional
      can [:create, :update], Shift
    end
  end
end

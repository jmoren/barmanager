class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
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

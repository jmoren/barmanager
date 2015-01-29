class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can :index, Promotion
      can :index, Item
      can :index, Category

      can [:read, :open, :close], Table
      can [:move_to, :edit, :update, :destroy], Ticket
      can :create, Shift
      can [:close, :show], Shift, user_id: user.id
    end
  end
end

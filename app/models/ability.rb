class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      cannot :manage, User
      cannot :manage, Category

      can :index, Item
      can :index, Promotion

      can [:read, :open], Table
      can [:move_to, :edit, :update, :delete], Ticket
      can :create, Shift
      can :close, Shift, user_id: user.id
    end
  end
end

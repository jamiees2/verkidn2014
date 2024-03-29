class Ability
  include CanCan::Ability

  def initialize ( user )
    user ||= User.new # guest user
    if user.role? :manager
      can :manage , :all
    elsif user.role? :worker
      can :read, [ Project, Task, Assignment, User ]
      can :manage, WorkLog 
      # manage products, assets he owns
      can :update , Task do | work_part |
        work_part.open? and work_part.users.include? user
      end
      # can :manage , Asset do | asset |
      #   asset. assetable try ( :owner ) == user
      # end
    end
  end
end
# class Ability
#   include CanCan::Ability
#
#   def initialize(user)
#     # Define abilities for the passed in user here. For example:
#     #
#     #   user ||= User.new # guest user (not logged in)
#     #   if user.admin?
#     #     can :manage, :all
#     #   else
#     #     can :read, :all
#     #   end
#     #
#     # The first argument to `can` is the action you are giving the user
#     # permission to do.
#     # If you pass :manage it will apply to every action. Other common actions
#     # here are :read, :create, :update and :destroy.
#     #
#     # The second argument is the resource the user can perform the action on.
#     # If you pass :all it will apply to every resource. Otherwise pass a Ruby
#     # class of the resource.
#     #
#     # The third argument is an optional hash of conditions to further filter the
#     # objects.
#     # For example, here the user can only update published articles.
#     #
#     #   can :update, Article, :published => true
#     #
#     # See the wiki for details:
#     # https://github.com/ryanb/cancan/wiki/Defining-Abilities
#
#   end
# end

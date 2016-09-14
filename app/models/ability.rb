class Ability
  include CanCan::Ability

  def initialize(user)

    if user
      can [:create, :render_modal], Task

      can [:read, :edit, :destroy], Task do |task|
        task.users.include?(user)
      end

      can :share, Task do |task|
        task.creator == user
      end
    end
  end
end

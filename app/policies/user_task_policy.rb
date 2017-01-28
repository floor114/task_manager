class UserTaskPolicy
  attr_reader :user, :task

  def initialize(user, task)
    @user = user
    @task = task
  end

  def can_edit?
    user.can? :edit, task
  end

  def can_delete?
    user.can? :destroy, task
  end

  def can_share?
    user.can?(:share, task) && user_query.user_to_share.present?
  end

  def creator?
    task.creator == user
  end

  private

  def user_query
    @user_query ||= UserQuery.new(User.all, task: task)
  end
end

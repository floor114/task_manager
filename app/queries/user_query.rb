class UserQuery
  attr_reader :users, :task, :options

  def initialize(users = User.all, options = {})
    @users = users
    @task = options[:task]
    @options = {}
  end

  def user_to_share
    users.all_except(task.users)
  end
end

# Create users
['first', 'second', 'third'].each do |prefix|
  User.create(
      email: "#{prefix}@user.com",
      password: '12345678',
      password_confirmation: '12345678',
      confirmed_at: DateTime.now
  )
end

# Create tasks
User.all.each do |user|
  Random.new.rand(0..10).times do
    task = Task.create(
        text: Faker::Hipster.sentence,
        updated_at: Faker::Date.between(1.year.ago, Date.today)
    )
    user.users_tasks.create(task: task)
  end
end

# Share tasks
Task.all.each do |task|
  Random.new.rand(0..task.users.size).times do
    task.share(User.all_except(Task.last.users).ids.shuffle.first)
  end
end

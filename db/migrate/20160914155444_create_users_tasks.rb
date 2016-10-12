class CreateUsersTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :users_tasks do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :user_type, default: 0

      t.timestamps
    end
  end
end

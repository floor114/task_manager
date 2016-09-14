class TasksController < ApplicationController
  load_and_authorize_resource except: [:index]
  before_action :authenticate_user!
  before_action :set_task, only: [:edit, :update, :destroy, :share]
  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      current_user.users_tasks.create(task: @task)
      respond_to :js
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  def share
    @task.share(params[:user_email])
    respond_to :js
  end

  def render_modal
    @task = params[:id].nil? ? Task.new : Task.find(params[:id])
    @target = params[:target]
    respond_to :js
  end

  private
    def task_params
      params.require(:task).permit(:text)
    end

    def set_task
      @task = Task.find(params[:id])
    end
end

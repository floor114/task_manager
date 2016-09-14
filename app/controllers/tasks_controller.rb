class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :share]
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
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
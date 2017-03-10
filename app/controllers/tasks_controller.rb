class TasksController < ApplicationController
  load_and_authorize_resource except: [:index]
  before_action :authenticate_user!
  before_action :set_task, only: [:edit, :update, :destroy, :share]
  protect_from_forgery except: :render_modal

  def index
    process_params!(params)
    run Task::Index
    render_view :index
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    current_user.users_tasks.create(task: @task) if @task.save
    respond_to :js
  end

  def edit
  end

  def update
    @task.update(task_params)
  end

  def destroy
    @task.destroy
  end

  def share
    @users = params[:users].split(',')
    @users.each{ |user| @task.share(user) }
    respond_to :js
  end

  def render_modal
    if params[:id].nil?
      @task = Task.new
    else
      @task = Task.find(params[:id])
      @users = User.all_except(@task.users).pluck(:id, :email)
    end
    respond_to :js
  end

  private
    def task_params
      params.require(:task).permit(:text)
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def render_view(action, options = {})
      render html:
        concept("task/cell/#{action}", @model, render_options), layout: options.fetch(:layout, true)
    end

    def render_options
      {
        form: @form
      }
    end
end

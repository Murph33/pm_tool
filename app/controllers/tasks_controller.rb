class TasksController < ApplicationController
  before_action :find_project, only: [:edit, :create]
  before_action :authenticate_user!

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find params[:id]
    @project = Project.find(@task.project_id)
  end

  def destroy
    @task = Task.find params[:id]
    @task.destroy
    flash[:notice] = "Task successfully deleted"
    redirect_to "/projects/#{(params[:project_id])}"
  end

  def create
    @project = Project.find params[:project_id]
    task_params = params.require(:task).permit(:title, :description, :due_date)
    @task = Task.new task_params
    @task.project = @project
    @task.user = current_user
    if @task.save
      flash[:notice] = "You've successfully created a task"
      redirect_to "/projects/#{(params[:project_id])}"
    else
      @discussion = Discussion.new
      flash[:alert] = "Something went wrong here"
      render "/projects/show"
    end
  end


  def update
    @task_params = params.require(:task).permit(:title, :description, :due_date, :done)
    @task = Task.find params[:id]
    if @task.update @task_params
      @task.done = params[:task][:done]
      if @task.done == true
        TasksMailer.notify_task_owner(@task).deliver_now unless @task.user == current_user
      end
      flash[:notice] = "Task udpated!"
      redirect_to "/projects/#{(params[:project_id])}"
    else
      flash[:alert] = "Something went wrong"
      render :edit
    end
  end

  private

  def find_project
    @project = Project.find params[:project_id]
  end

end

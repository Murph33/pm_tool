class TasksController < ApplicationController

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
    @discussion = Discussion.new
    @project = Project.find params[:project_id]
    task_params = params.require(:task).permit(:title, :description, :due_date)
    @task = Task.new task_params
    @task.project = @project
    @tasks = @project.tasks
    @discussions = @project.discussions
    @task.user = current_user
    if @task.save
      flash[:notice] = "You've successfully created a task"
      redirect_to "/projects/#{(params[:project_id])}"
    else
      flash[:alert] = "Something went wrong here"
      render "/projects/show"
    end
  end



  def update
    @discussion = Discussion.new
    @project = Project.find params[:project_id]
    @task_params = params.require(:task).permit(:title, :description, :due_date, :done)
    @task = Task.find params[:id]
    @task.project = @project
    @tasks = @project.tasks
    @discussions = @project.discussions
    if @task.update @task_params
      @task.done = params[:task][:done]
      flash[:notice] = "Task udpated!"
      redirect_to "/projects/#{(params[:project_id])}"
    else
      flash[:alert] = "Something went wrong"
      render :edit
    end
  end
end

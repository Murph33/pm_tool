class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    @project = Project.find params[:project_id]
    task_params = params.require(:task).permit(:title, :description, :due_date)
    @task = Task.new task_params
    @task.project = @project
    if @task.save
      flash[:notice] = "You've successfully created a task"
      redirect_to "/projects/#{(params[:project_id])}"
    else
      flash[:alert] = "Something went wrong here"
      render "/projects/show"
    end
  end
end

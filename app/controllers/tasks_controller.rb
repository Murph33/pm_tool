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
    respond_to do |format|
      format.js { render }
      format.html {flash[:notice] = "Task successfully deleted"
                   redirect_to "/projects/#{(params[:project_id])}"}
    end
  end

  def create
    @project = Project.find params[:project_id]
    task_params = params.require(:task).permit(:title, :description, :due_date)
    @task = Task.new task_params
    @task.project = @project
    @task.user = current_user
    respond_to do |format|
      if @task.save
        flash[:notice] = "You've successfully created a task"
        format.js { render }
        format.html { redirect_to "/projects/#{(params[:project_id])}" }
      else
        @discussion = Discussion.new
        flash[:alert] = "Something went wrong here"
        format.js {render "create_failure" }
        format.html { render "/projects/show" }
      end
    end
  end


  def update
    @task_params = params.require(:task).permit(:title, :description, :due_date, :done)
    @task = Task.find params[:id]
    task_status = @task.done
    @project = Project.find params[:project_id]
    respond_to do |format|
      if @task.update @task_params
        @task.done = params[:task][:done] if params[:task][:done]
        if @task.done == true
          TasksMailer.delay.notify_task_owner(@task) unless @task.user == current_user
        end
        format.js { render "donetoggle"} if task_status != @task.done
        flash[:notice] = "Task udpated!"
        format.js { render }
        format.html { redirect_to "/projects/#{(params[:project_id])}" }
      else
        flash[:alert] = "Something went wrong"
        format.js { render }
        format.html { render :edit }
      end
    end
  end

  private

  def find_project
    @project = Project.find params[:project_id]
  end

end

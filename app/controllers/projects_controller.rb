class ProjectsController < ApplicationController

  PER_PAGE = 10

  def index

    @page = params[:page] ? params[:page].to_i : 1
    if params[:search]
      @total_projects = Project.search(params[:search])
      @projects = @total_projects.offset((@page - 1) * PER_PAGE).limit(PER_PAGE)
    else
      @projects = Project.offset((@page - 1) * PER_PAGE).limit(PER_PAGE)
      @total_projects = Project.all
    end
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find params[:id]
  end

  def update
    project_params = params.require(:project).permit(:title, :description, :due_date)
    @project = Project.find params[:id]
    if @project.update project_params
      flash[:notice] = "Project successfully updated"
      redirect_to project_path(@project)
    else
      flash[:alarm] = "Something went wrong here!!"
      render :edit
    end
  end

  def create
    project_params = params.require(:project).permit(:title, :description, :due_date)
    @project = Project.new project_params
    if @project.save
      flash[:notice] = "You have created a new Project"
      redirect_to @project
    else
      flash[:alert] = "Something has gone wrong here!!"
      render :new
    end
  end

  def destroy
    @project = Project.find params[:id]
    @project.destroy
    redirect_to projects_path
  end

  def show
    @project = Project.find params[:id]
    @task = Task.new
    @tasks = @project.tasks
  end
end

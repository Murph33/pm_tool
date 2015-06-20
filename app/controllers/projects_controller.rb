class ProjectsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  before_action :authorize!, only: [:edit, :update, :destroy]

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
    project_params = params.require(:project).permit(:title, :description,
                      {tag_ids: []}, {collaborating_user_ids: []},  :due_date)

    @project = Project.find params[:id]
    project_params[:collaborating_user_ids] << current_user.id unless @project.user == current_user

    if @project.update project_params
      flash[:notice] = "Project successfully updated"
      redirect_to project_path(@project)
    else
      flash[:alarm] = "Something went wrong here!!"
      render :edit
    end
  end

  def create
    project_params = params.require(:project).permit(:title, :description,
                      {tag_ids: []}, {collaborating_user_ids: []},  :due_date)
    @project = Project.new project_params
    @project.user = current_user
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
    @comment = Comment.new
    @discussion = Discussion.new
    @tasks_done = Task.where("done = true AND project_id = #{params[:id]}")
    @tasks_not_done = Task.where("done = false AND project_id = #{params[:id]}")
    @discussions = @project.discussions
    @favourite = @project.favourite_for current_user
  end

  private

  def authorize!
    project = Project.find(params[:id])
    unless (project.user == current_user || project.collaborating_users.include?(current_user))
      redirect_to project, notice: "Access denied"
    end
  end
end

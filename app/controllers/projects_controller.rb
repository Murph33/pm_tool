class ProjectsController < ApplicationController

  def index
    if params[:search]
      @projects = Project.search(params[:search])
      end
    @projects ||= Project.all
  end
end

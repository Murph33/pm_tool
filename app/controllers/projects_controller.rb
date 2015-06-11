class ProjectsController < ApplicationController

  PER_PAGE = 10

  def index
  # params[:page] ? @page = params[:page] : @page = 1
    @page = params[:page] ? params[:page].to_i : 1
    if params[:search]
      @total_projects = Project.search(params[:search])
      @projects = Project.search(params[:search]).offset((@page - 1) * PER_PAGE).limit(PER_PAGE)
    else
      @projects = Project.offset((@page - 1) * PER_PAGE).limit(PER_PAGE)
      @total_projects = Project.all
    end
    @number_of_projects = @projects.length == 0 ? nil : @projects.length * @page
    #@total_projects = Project.search()
    @holder = Project.all.length
    @holder2 = @projects.length
    @check = PER_PAGE
  end
end

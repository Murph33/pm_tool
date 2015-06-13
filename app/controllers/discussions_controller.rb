class DiscussionsController < ApplicationController

  def show
    @discussion = Discussion.find params[:id]
    @comment = Comment.new
    @comments = @discussion.comments
  end

  def create
    discussion_params = params.require(:discussion).permit(:project_id, :title,
                                                          :description)
    @project = Project.find params[:project_id]
    @task = Task.new
    @tasks = @project.tasks
    @discussion = Discussion.new discussion_params
    @discussion.project = @project
    if @discussion.save
      flash[:notice] = "New discussion started"
      redirect_to project_path(params[:project_id])
    else
      flash[:alarm] = "Something went wrong!"
      render "/projects/show/#{discussion_params[:project_id]}"
    end
  end

  def edit
    @discussion = Discussion.find params[:id]
    @project = Project.find(@discussion.project_id)
  end

  def update
    @discussion = Discussion.find params[:id]
    project = Project.find @discussion.project_id
    discussion_params = params.require(:discussion).permit(:title, :description)
    if @discussion.update discussion_params
      flash[:notice] = "Discussion successfully updated!"
      redirect_to project
    else
      flash[:alarm] = "Something went wrong!"
      render :edit
    end
  end

  def destroy
    discussion = Discussion.find params[:id]
    project = Project.find discussion.project_id
    discussion.destroy
    flash[:notice] = "Discussion successfully deleted."
    redirect_to project
  end
end

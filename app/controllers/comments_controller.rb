class CommentsController < ApplicationController

  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    comment_params = params.require(:comment).permit(:body)
    discussion = Discussion.find params[:discussion_id]
    project = Project.find discussion.project_id
    @comment = Comment.new comment_params
    @comment.user = current_user
    @comment.discussion = discussion
    if @comment.save
      DiscussionsMailer.notify_discussion_owner(discussion).deliver_now unless @comment.user == discussion.user
      flash[:notice] = "Comment successfully posted!"
      redirect_to project_discussion_path(project, discussion)
    else
      flash[:alert] = "Something went wrong!"
      redirect_to project_discussion_path(project, discussion)
    end
  end

  def edit
    @comment = Comment.find params[:id]
    @discussion = Discussion.find @comment.discussion_id
  end

  def update
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.find params[:id]
    @discussion = Discussion.find params[:discussion_id]
    project = Project.find @discussion.project_id
    if @comment.update comment_params
      flash[:notice] = "Comment updated!"
      redirect_to project_discussion_path(project, @discussion)
    else
      flash[:alert] = "Something went wrong!"
      render "/comments/edit"
    end
  end

  def destroy
    comment = Comment.find params[:id]
    @discussion = Discussion.find comment.discussion_id
    @project = Project.find @discussion.project_id
    comment.destroy
    flash[:notice] = "Comment successfully deleted."
    redirect_to project_discussion_path(@project, @discussion)
  end

end

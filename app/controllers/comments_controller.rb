class CommentsController < ApplicationController

  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    comment_params = params.require(:comment).permit(:body)
    @discussion = Discussion.find params[:discussion_id]
    project = Project.find @discussion.project_id
    @comment = Comment.new comment_params
    @comment.user = current_user
    @comment.discussion = @discussion
    respond_to do |format|
      if @comment.save
        DiscussionsMailer.delay.notify_discussion_owner(@discussion) unless @comment.user == @discussion.user
        format.js { render }
        format.html { flash[:notice] = "Comment successfully posted!"
        redirect_to project_discussion_path(project, @discussion) }
        else
        format.js { render "create_failure" }
        format.html { flash[:alert] = "Something went wrong!"
        redirect_to project_discussion_path(project, @discussion) }
      end
    end
  end

  def edit
    @comment = Comment.find params[:id]
    @discussion = Discussion.find @comment.discussion_id
    respond_to do |format|
      format.js { render }
    end
  end

  def update
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.find params[:id]
    @discussion = Discussion.find params[:discussion_id]
    project = Project.find @discussion.project_id
    respond_to do |format|
      if @comment.update comment_params
        format.js   { render }
        format.html { flash[:notice] = "Comment updated!"
                    redirect_to project_discussion_path(project, @discussion) }
        else
        format.js   { render }
        format.html { flash[:alert] = "Something went wrong!"
                    render "/comments/edit" }
      end
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    @discussion = Discussion.find @comment.discussion_id
    @project = Project.find @discussion.project_id
    @comment.destroy
    respond_to do |format|
      format.js { render }
      format.html { flash[:notice] = "Comment successfully deleted."
                    redirect_to project_discussion_path(@project, @discussion) }
    end
  end

end

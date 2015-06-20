class DiscussionsMailer < ApplicationMailer

  def notify_discussion_owner (discussion)
    @discussion = discussion
    @user = discussion.user
    mail(to: @user.email, subject: "New comment on #{discussion.title}" )
  end
end

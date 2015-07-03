class ScheduledMailer < ApplicationMailer

  def notify_webmaster(tasks, discussions)
    @tasks = tasks
    @discussions = discussions
    email = "murph33@gmail.com"
    mail(to: email, subject: "TASK AND DISCUSSION SUMMARY")
  end

end

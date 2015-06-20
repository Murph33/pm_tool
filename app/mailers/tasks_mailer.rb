class TasksMailer < ApplicationMailer

  def notify_task_owner (task)
    @task = task
    @user = task.user
    mail(to: @user.email, subject: "Your task is complete" )
  end
end

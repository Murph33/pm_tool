namespace :email_summary do

  desc "This sends a summary of the events daily"

  task run: :environment do
    tasks = Task.where('created_at > ?', 1.day.ago)
    discussions = Discussion.where('created_at > ?', 1.day.ago)
    ScheduledMailer.notify_webmaster(tasks,discussions).deliver_now
     tasks.each do |task|

    puts  task.title

     end
     discussions.each do |task|

    puts  task.title

     end
   end

end

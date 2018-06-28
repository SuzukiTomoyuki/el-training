class RelationshipMailer < ApplicationMailer
  def oko_notification(user, sender, task)
    @user = user
    @sender = sender
    @task = task
    @sub_time_day = Time.at((Time.now - task.deadline)).day - 2
    # pp @sub_time_day
    mail from: "#{sender.name} <#{sender.email}>" ,to: user.email, subject: "おこだぞ！"
  end
end

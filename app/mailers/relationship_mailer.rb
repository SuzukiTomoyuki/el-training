class RelationshipMailer < ApplicationMailer
  def oko_notification(from_user, to_user, task)
    @from_user = from_user
    @to_user = to_user
    @task = task
    @sub_time_day = Time.at((Time.now - task.deadline)).day - 2
    pp @sender
    mail from: "#{from_user.name} <#{from_user.email}>" ,to: to_user.email, subject: "おこだぞ！"
  end
end

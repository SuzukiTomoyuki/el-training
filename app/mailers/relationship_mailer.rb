class RelationshipMailer < ApplicationMailer
  def oko_notification(user, sender, task)
    @user = user
    @sender = sender
    @task = task
    mail to: user.email, subject: "おこだぞ！"
  end
end

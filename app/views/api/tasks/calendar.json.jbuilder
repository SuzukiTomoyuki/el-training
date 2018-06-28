json.array! @tasks do |task|
  json.group task[:group]
  json.caption task[:caption]
  json.taskId task[:task_id]
  json.chargeUser task[:charge_user]
  json.chargeUserId task[:charge_user_id]
  json.deadline task[:deadline]
  json.userImage task[:user_image]
end

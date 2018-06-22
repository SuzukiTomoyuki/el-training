json.array! @tasks do |task|
  json.group task[:group]
  json.caption task[:caption]
  json.chargeUser task[:charge_user]
  json.deadline task[:deadline]
end
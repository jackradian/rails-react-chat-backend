# frozen_string_literal: true
json.err(0)
json.rooms(@rooms) do |room|
  json.id(room.id)
  room.participants.each do |p|
    if p.user_id == current_user.id
      json.is_current(p.is_current)
      break
    end
  end
  room.users.each do |u|
    next if u.id == current_user.id
    json.user_nickname(u.nickname)
  end
  json.messages(room.messages) do |msg|
    json.id(msg.id)
    json.sender_nickname(msg.sender_nickname)
    json.sent_at(msg.sent_at.strftime("%Y/%m/%d %H:%M"))
    json.content(msg.content)
  end
end

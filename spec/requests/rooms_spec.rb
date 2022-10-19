# frozen_string_literal: true
require "rails_helper"

RSpec.describe("Rooms", type: :request) do
  describe "GET /my_direct_rooms" do
    context "when have not any room" do
      it "response with empty room array" do
        user = FactoryBot.create(:user)

        sign_in_as(user)
        headers = { "ACCEPT" => "application/json" }
        get(my_direct_rooms_url, headers: headers)
        expect(response).to(have_http_status(:success))
        json = JSON.parse(response.body)
        expect(json["err"]).to(eq(0))
        expect(json["rooms"]).to(eq([]))
      end
    end
    context "when have rooms" do
      it "response with rooms array and their participants and messages" do
        user = FactoryBot.create(:user)
        friend_1 = FactoryBot.create(:user)
        friend_2 = FactoryBot.create(:user)

        room_1 = FactoryBot.create(
          :room,
          :with_ten_direct_messages_of_two_users,
          participant_1: user,
          participant_2: friend_1
        )
        room_2 = FactoryBot.create(
          :room,
          :with_ten_direct_messages_of_two_users,
          participant_1: user,
          participant_2: friend_2
        )

        sign_in_as(user)
        headers = { "ACCEPT" => "application/json" }
        get(my_direct_rooms_url, headers: headers)
        expect(response).to(have_http_status(:success))
        json = JSON.parse(response.body)

        expect(json["err"]).to(eq(0))
        rooms = json["rooms"]
        expect(rooms.size).to(eq(2))

        expected_rooms = [room_1, room_2]
        expected_data = Jbuilder.encode do |jbuilder|
          jbuilder.err(0)
          jbuilder.rooms(expected_rooms) do |room|
            jbuilder.id(room.id)
            room.participants.each do |p|
              if p.user_id == user.id
                jbuilder.is_current(p.is_current)
                break
              end
            end
            room.users.each do |u|
              next if u.id == user.id
              jbuilder.user_nickname(u.nickname)
            end
            jbuilder.messages(room.messages) do |msg|
              jbuilder.id(msg.id)
              jbuilder.sender_nickname(msg.sender_nickname)
              jbuilder.sent_at(msg.sent_at.strftime("%Y/%m/%d %H:%M"))
              jbuilder.content(msg.content)
            end
          end
        end
        expected_data = JSON.parse(expected_data)
        expect(
          is_two_arrays_have_same_elements(expected_data["rooms"], rooms)
        ).to(eq(true))
      end
    end
  end
end

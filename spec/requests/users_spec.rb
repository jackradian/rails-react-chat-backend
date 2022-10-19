# frozen_string_literal: true
require "rails_helper"

RSpec.describe("Users", type: :request) do
  let(:valid_data) do
    {
      email: "test@example.com",
      password: "123456",
      nickname: "Test User",
      first_name: "John",
      last_name: "Wick"
    }
  end
  let(:data_with_blank_email) do
    data = valid_data
    data["email"] = nil
    data
  end
  let(:data_with_blank_password) do
    data = valid_data
    data["password"] = nil
    data
  end
  let(:data_with_short_password) do
    data = valid_data
    data["password"] = "1" * 5
    data
  end
  let(:data_with_long_password) do
    data = valid_data
    data["password"] = "1" * 129
    data
  end
  let(:data_with_blank_nickname) do
    data = valid_data
    data["nickname"] = nil
    data
  end
  let(:data_with_blank_first_name) do
    data = valid_data
    data["first_name"] = nil
    data
  end
  let(:data_with_blank_last_name) do
    data = valid_data
    data["last_name"] = nil
    data
  end

  let(:headers) do
    { "ACCEPT" => "application/json" }
  end

  let(:existed_user) { FactoryBot.create(:user) }

  describe "POST /signup" do
    context "with valid parameters" do
      it "creates a new User" do
        expect do
          post signup_url, params: valid_data, headers: headers
        end.to(change(User, :count).by(1))
      end
      it "renders a JSON response with the new user info" do
        post signup_url, params: valid_data, headers: headers
        expect(response).to(have_http_status(:success))
        json = JSON.parse(response.body)
        expect(json["err"]).to(eq(0))
        expect(json["msg"]).to(eq("Sign up success"))
        expect(json["email"]).to(eq("test@example.com"))
        expect(json["nickname"]).to(eq("Test User"))
      end
    end

    context "with blank email" do
      it "does not create a new User" do
        expect do
          post signup_url, params: data_with_blank_email, headers: headers
        end.to(change(User, :count).by(0))
      end
      it "renders a JSON response with error email blank" do
        post signup_url, params: data_with_blank_email, headers: headers
        expect(response).to(have_http_status(400))
        json = JSON.parse(response.body)
        expect(json["err"]).to(eq(1))
        expect(json["err_arr"]).to(eq(["Email can't be blank"]))
      end
    end

    context "with existed email" do
      it "does not create a new User" do
        data = valid_data
        data["email"] = existed_user.email
        expect do
          post signup_url, params: data, headers: headers
        end.to(change(User, :count).by(0))
      end
      it "renders a JSON response with error existed email" do
        data = valid_data
        data["email"] = existed_user.email
        post signup_url, params: data, headers: headers
        expect(response).to(have_http_status(400))
        json = JSON.parse(response.body)
        expect(json["err"]).to(eq(1))
        expect(json["err_arr"]).to(eq(["Email has already been taken"]))
      end
    end

    context "with blank password" do
      it "does not create a new User" do
        expect do
          post signup_url, params: data_with_blank_password, headers: headers
        end.to(change(User, :count).by(0))
      end
      it "renders a JSON response with error blank password" do
        post signup_url, params: data_with_blank_password, headers: headers
        expect(response).to(have_http_status(400))
        json = JSON.parse(response.body)
        expect(json["err"]).to(eq(1))
        expect(json["err_arr"]).to(eq(["Password can't be blank", "Password is too short (minimum is 6 characters)"]))
      end
    end

    context "with password too short" do
      it "does not create a new User" do
        expect do
          post signup_url, params: data_with_short_password, headers: headers
        end.to(change(User, :count).by(0))
      end
      it "renders a JSON response with error password too short" do
        post signup_url, params: data_with_short_password, headers: headers
        expect(response).to(have_http_status(400))
        json = JSON.parse(response.body)
        expect(json["err"]).to(eq(1))
        expect(json["err_arr"]).to(eq(["Password is too short (minimum is 6 characters)"]))
      end
    end

    context "with password too long" do
      it "does not create a new User" do
        expect do
          post signup_url, params: data_with_long_password, headers: headers
        end.to(change(User, :count).by(0))
      end
      it "renders a JSON response with error password too long" do
        post signup_url, params: data_with_long_password, headers: headers
        expect(response).to(have_http_status(400))
        json = JSON.parse(response.body)
        expect(json["err"]).to(eq(1))
        expect(json["err_arr"]).to(eq(["Password is too long (maximum is 72 characters)"]))
      end
    end

    context "with blank nickname" do
      it "does not create a new User" do
        expect do
          post signup_url, params: data_with_blank_nickname, headers: headers
        end.to(change(User, :count).by(0))
      end
      it "renders a JSON response with error nickname blank" do
        post signup_url, params: data_with_blank_nickname, headers: headers
        expect(response).to(have_http_status(400))
        json = JSON.parse(response.body)
        expect(json["err"]).to(eq(1))
        expect(json["err_arr"]).to(eq(["Nickname can't be blank"]))
      end
    end

    context "with existed nickname" do
      it "does not create a new User" do
        data = valid_data
        data["nickname"] = existed_user.nickname
        expect do
          post signup_url, params: data, headers: headers
        end.to(change(User, :count).by(0))
      end
      it "renders a JSON response with error existed nickname" do
        data = valid_data
        data["nickname"] = existed_user.nickname
        post signup_url, params: data, headers: headers
        expect(response).to(have_http_status(400))
        json = JSON.parse(response.body)
        expect(json["err"]).to(eq(1))
        expect(json["err_arr"]).to(eq(["Nickname has already been taken"]))
      end
    end

    context "with blank first_name" do
      it "does not create a new User" do
        expect do
          post signup_url, params: data_with_blank_first_name, headers: headers
        end.to(change(User, :count).by(0))
      end
      it "renders a JSON response with error first_name blank" do
        post signup_url, params: data_with_blank_first_name, headers: headers
        expect(response).to(have_http_status(400))
        json = JSON.parse(response.body)
        expect(json["err"]).to(eq(1))
        expect(json["err_arr"]).to(eq(["First name can't be blank"]))
      end
    end

    context "with blank last_name" do
      it "does not create a new User" do
        expect do
          post signup_url, params: data_with_blank_last_name, headers: headers
        end.to(change(User, :count).by(0))
      end
      it "renders a JSON response with error last_name blank" do
        post signup_url, params: data_with_blank_last_name, headers: headers
        expect(response).to(have_http_status(400))
        json = JSON.parse(response.body)
        expect(json["err"]).to(eq(1))
        expect(json["err_arr"]).to(eq(["Last name can't be blank"]))
      end
    end
  end

  describe "POST /add_friend" do
    let!(:current_user) { FactoryBot.create(:user) }
    let(:another_user) { FactoryBot.create(:user) }
    before(:each) do
      sign_in_as(current_user)
    end
    context "with nickname exists and not be added" do
      it "creates a direct room with current_user and user that have that nickname as participants" do
        expect do
          headers = { "ACCEPT" => "application/json" }
          post(add_friend_url, params: { keyword: another_user.nickname }, headers: headers)

          room = Room.first
          expect(
            is_two_arrays_have_same_elements(
              [room.participants.first.user, room.participants.second.user],
              [current_user, another_user]
            )
          ).to(eq(true))
          expect(current_user.participants.first.status).to(eq(:accepted.to_s))
          expect(another_user.participants.first.status).to(eq(:invite_pending.to_s))

          expect(response).to(have_http_status(200))
          json = JSON.parse(response.body)
          expect(json["err"]).to(eq(0))
          expect(json["room"]).to(eq({
            "id" => room.id,
            "is_current" => 0,
            "user_nickname" => another_user.nickname,
            "messages" => []
          }))
        end.to(change(Room, :count).by(1)
          .and(change(Participant, :count).by(2)))
      end
    end

    context "with email exists and not be added" do
      it "creates a direct room with current_user and user that have that email as participants" do
        expect do
          headers = { "ACCEPT" => "application/json" }
          post(add_friend_url, params: { keyword: another_user.email }, headers: headers)

          room = Room.first
          expect(
            is_two_arrays_have_same_elements(
              [room.participants.first.user, room.participants.second.user],
              [current_user, another_user]
            )
          ).to(eq(true))
          expect(current_user.participants.first.status).to(eq(:accepted.to_s))
          expect(another_user.participants.first.status).to(eq(:invite_pending.to_s))

          expect(response).to(have_http_status(200))
          json = JSON.parse(response.body)
          expect(json["err"]).to(eq(0))
          expect(json["room"]).to(eq({
            "id" => room.id,
            "is_current" => 0,
            "user_nickname" => another_user.nickname,
            "messages" => []
          }))
        end.to(change(Room, :count).by(1)
          .and(change(Participant, :count).by(2)))
      end
    end

    context "with keyword does not match with any user" do
      it "does not create room and response error 404" do
        expect do
          headers = { "ACCEPT" => "application/json" }
          post(add_friend_url, params: { keyword: "not exist" }, headers: headers)

          expect(response).to(have_http_status(404))
          json = JSON.parse(response.body)
          expect(json["err"]).to(eq(1))
          expect(json["msg"]).to(eq("Email or Nickname doesn't exist"))
        end.to(change(Room, :count).by(0)
          .and(change(Participant, :count).by(0)))
      end
    end

    context "with nickname of user that is added" do
      it "does not create room and response error 403" do
        FactoryBot.create(
          :room,
          :with_two_participants,
          room_type: :direct_room,
          participant_1: current_user,
          participant_2: another_user
        )
        expect do
          headers = { "ACCEPT" => "application/json" }
          post(add_friend_url, params: { keyword: another_user.nickname }, headers: headers)

          expect(response).to(have_http_status(403))
          json = JSON.parse(response.body)
          expect(json["err"]).to(eq(1))
          expect(json["msg"]).to(eq("This user has already been added"))
        end.to(change(Room, :count).by(0)
          .and(change(Participant, :count).by(0)))
      end
    end

    context "with email of user that is added" do
      it "does not create room and response error 403" do
        FactoryBot.create(
          :room,
          :with_two_participants,
          room_type: :direct_room,
          participant_1: current_user,
          participant_2: another_user
        )

        expect do
          headers = { "ACCEPT" => "application/json" }
          post(add_friend_url, params: { keyword: another_user.email }, headers: headers)

          expect(response).to(have_http_status(403))
          json = JSON.parse(response.body)
          expect(json["err"]).to(eq(1))
          expect(json["msg"]).to(eq("This user has already been added"))
        end.to(change(Room, :count).by(0)
          .and(change(Participant, :count).by(0)))
      end
    end
  end
end

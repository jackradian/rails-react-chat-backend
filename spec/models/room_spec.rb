# frozen_string_literal: true
require "rails_helper"

RSpec.describe(Room, type: :model) do
  #
  # Database structures
  #
  it { should have_db_column(:room_type).of_type(:integer).with_options(default: :direct_room, null: false) }

  #
  # Associations
  #
  it { should have_many(:participants).dependent(:destroy) }
  it { should have_many(:users).through(:participants) }
  it { should have_many(:messages).order(:sent_at).dependent(:destroy) }

  #
  # Enums
  #
  it do
    should define_enum_for(:room_type)
      .with_values(direct_room: 0, public_room: 1, private_room: 2)
  end

  #
  # Class methods
  #
  describe "#direct_room_by_id" do
    context "when they are not friend" do
      it "return empty array" do
        user_1 = FactoryBot.create(:user)
        user_2 = FactoryBot.create(:user)
        expect(Room.direct_room_by_id(user_1.id, user_2.id)).to(eq([]))
      end
    end
    context "when they are friend" do
      it "return array with one room record" do
        user_1 = FactoryBot.create(:user)
        user_2 = FactoryBot.create(:user)
        room = FactoryBot.create(:room)
        FactoryBot.create(:participant, room: room, user: user_1)
        FactoryBot.create(:participant, room: room, user: user_2)
        expect(Room.direct_room_by_id(user_1.id, user_2.id)).to(eq([room]))
      end
    end
  end
end

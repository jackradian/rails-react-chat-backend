# frozen_string_literal: true
require "rails_helper"

RSpec.describe(Message, type: :model) do
  #
  # Database structures
  #
  it { should have_db_column(:room_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:sender_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:sent_at).of_type(:datetime) }
  it { should have_db_column(:content).of_type(:text) }
  it { should have_db_index(:room_id) }
  it { should have_db_index(:sender_id) }
  it { should have_db_index(:sent_at) }

  #
  # Associations
  #
  it { should belong_to(:room) }
  it { should belong_to(:sender).class_name("User") }

  #
  # Instance methods
  #
  describe "#sender_nickname" do
    it "return sender nickname" do
      user = FactoryBot.build(:user)
      message = FactoryBot.build(:message, sender: user)
      expect(message.sender_nickname).to(eq(user.nickname))
    end
  end
end

# frozen_string_literal: true
require "rails_helper"

RSpec.describe(Participant, type: :model) do
  #
  # Database structures
  #
  it { should have_db_column(:room_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:status).of_type(:integer).with_options(default: :invite_pending, null: false) }
  it { should have_db_column(:is_current).of_type(:boolean).with_options(default: false, null: false) }
  it { should have_db_index([:room_id, :user_id]) }
  it { should have_db_index(:user_id) }
  it { should have_db_index(:room_id) }

  #
  # Associations
  #
  it { should belong_to(:room) }
  it { should belong_to(:user) }

  #
  # Enums
  #
  it do
    should define_enum_for(:status)
      .with_values(invite_pending: 0, accepted: 1, block: 2)
  end
end

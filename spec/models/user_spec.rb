# frozen_string_literal: true
require "rails_helper"

RSpec.describe(User, type: :model) do
  it { should have_secure_password }

  #
  # Database structures
  #
  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:password_digest).of_type(:string) }
  it { should have_db_column(:nickname).of_type(:string) }
  it { should have_db_column(:first_name).of_type(:string) }
  it { should have_db_column(:last_name).of_type(:string) }
  it { should have_db_index(:email).unique }
  it { should have_db_index(:nickname).unique }

  #
  # Validations
  #
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it do
    should validate_length_of(:password)
      .is_at_least(6).is_at_most(72)
  end
  it { should validate_presence_of(:nickname) }
  it { should validate_uniqueness_of(:nickname) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  #
  # Associations
  #
  it { should have_many(:messages).inverse_of("sender") }
  it { should have_many(:participants) }
end

# frozen_string_literal: true
require "rails_helper"

RSpec.describe(RoomsController, type: :routing) do
  describe "routing" do
    it do
      should route(:get, "/my_direct_rooms")
        .to(controller: :rooms, action: :my_direct_rooms)
    end
  end
end

require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it do
      should route(:post, '/signup').
        to(controller: :users, action: :create)
    end
    it do
      should route(:post, '/add_friend').
        to(controller: :users, action: :add_friend)
    end
  end
end

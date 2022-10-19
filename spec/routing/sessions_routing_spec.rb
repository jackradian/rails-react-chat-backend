require "rails_helper"

RSpec.describe SessionsController, type: :routing do
  describe "routing" do
    it do
      should route(:post, '/login').
        to(controller: :sessions, action: :create)
    end
    it do
      should route(:get, '/logout').
        to(controller: :sessions, action: :destroy)
    end
  end
end

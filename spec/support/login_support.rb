# frozen_string_literal: true
module LoginSupport
  def sign_in_as(user)
    headers = { "ACCEPT" => "application/json" }
    post(login_url, params: { email: user.email, password: user.password }, headers: headers)
  end
end

RSpec.configure do |config|
  config.include(LoginSupport)
end

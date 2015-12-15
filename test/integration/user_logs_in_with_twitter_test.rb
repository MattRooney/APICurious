require 'test_helper'

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  def setup
    Capybara.app = WarPigeon::Application
    stub_omniauth
  end

  test "logging in" do
    visit "/"
    assert_equal 200, page.status_code
    click_link "Login with Twitter"
    assert_equal "/users/980190963", current_path
    assert page.has_content?("Matt")
    assert page.has_link?("Logout")
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      extra: {
        raw_info: {
          user_id: "1234",
          name: "Matt",
          screen_name: "rooney",
        }
      },
      credentials: {
        token: "bird",
        secret: "istheword"
      }
    })
  end
end

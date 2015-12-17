require 'test_helper'

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  def setup
    Capybara.app = WarPigeon::Application
    stub_omniauth
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
    { "provider"=>"twitter",
      "uid"=>"4581004634",
      "info"=>
      { "nickname"=>"matthewjrooney2",
        "name"=>"matt rooney",
        "email"=>nil,
        "location"=>"",
        "image"=>"http://abs.twimg.com/sticky/default_profile_images/default_profile_3_normal.png",
        "description"=>"",
        "urls"=>{"Website"=>nil, "Twitter"=>"https://twitter.com/matthewjrooney2"}},
      "credentials"=>
        {"token"=>"4581004634-Dq4MoIGKxuiZoeMr1zGeoWE5Gn83qXeBB5H6XZR",
         "secret"=>"Y5YzPDDowKW9gNSHmJ5hLwLYOCFs1dav1uxUshDJcZdgi"},
      "extra"=> {
        "raw_info"=>
          {"id"=>4581004634,
           "id_str"=>"4581004634",
           "name"=>"matt rooney",
           "screen_name"=>"matthewjrooney2",
           "location"=>"",
           "description"=>"",
           "url"=>nil,
           "entities"=>{"description"=>{"urls"=>[]}},
           "protected"=>false,
           "followers_count"=>1,
           "friends_count"=>2,
           "listed_count"=>0,
           "created_at"=>"Thu Dec 17 03:50:58 +0000 2015",
           "favourites_count"=>0,
           "utc_offset"=>nil,
           "time_zone"=>nil,
           "geo_enabled"=>false,
           "verified"=>false,
           "statuses_count"=>0,
           "lang"=>"en",
           "contributors_enabled"=>false,
           "is_translator"=>false,
           "is_translation_enabled"=>false,
           "profile_background_color"=>"F5F8FA",
           "profile_background_image_url"=>nil,
           "profile_background_image_url_https"=>nil,
           "profile_background_tile"=>false,
           "profile_image_url"=>"http://abs.twimg.com/sticky/default_profile_images/default_profile_3_normal.png",
           "profile_image_url_https"=>"https://abs.twimg.com/sticky/default_profile_images/default_profile_3_normal.png",
           "profile_link_color"=>"2B7BB9",
           "profile_sidebar_border_color"=>"C0DEED",
           "profile_sidebar_fill_color"=>"DDEEF6",
           "profile_text_color"=>"333333",
           "profile_use_background_image"=>true,
           "has_extended_profile"=>false,
           "default_profile"=>true,
           "default_profile_image"=>true,
           "following"=>false,
           "follow_request_sent"=>false,
           "notifications"=>false}}})
  end

  test "logging in" do
    visit "/"

    assert_equal 200, page.status_code

    click_link "Login with Twitter"

    assert_equal "/users/2", current_path
    assert page.has_content?("matt rooney")
    assert page.has_content?("matthewjrooney2")
    assert page.has_link?("Logout")
  end

  test "log in and log out" do
    visit "/"

    assert_equal 200, page.status_code

    click_link "Login with Twitter"

    assert_equal "/users/1", current_path
    assert page.has_content?("matt rooney")
    assert page.has_content?("matthewjrooney2")
    assert page.has_link?("Logout")

    click_link "Logout"

    assert_equal "/", current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Login with Twitter")
  end

end

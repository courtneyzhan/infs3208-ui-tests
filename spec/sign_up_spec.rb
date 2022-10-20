load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Sign up" do
  include TestHelper

  before(:all) do
    # browser_type, browser_options, site_url are defined in test_helper.rb
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(1280, 720)
    driver.get(site_url)
  end

  after(:all) do
    driver.quit unless debugging?
  end

  before(:each) do
  end

  it "Use can sign up" do
    # Choose a random user name
    driver.find_element(:id, "navbar-signup").click

    new_user_name = "test" + Faker::Number.number(digits: 6).to_s

    sign_up_page = SignUpPage.new(driver)
    sign_up_page.enter_username(new_user_name)
    sign_up_page.enter_password("test01")
    sign_up_page.enter_password_confirmation("test01")
    sign_up_page.click_sign_up_button
    
    sleep 1
    login(new_user_name, "test01")
    sleep 1
    expect(page_text).to include(new_user_name)
  end
end

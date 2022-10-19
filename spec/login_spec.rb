load File.dirname(__FILE__) + "/../test_helper.rb"

describe "User Authentication" do
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
    driver.find_element(:id, "navbar-login").click
  end

  it "Login ok" do
    expect(page_text).not_to include("Username or password is invalid")
    login("Courtney", "test01")
    sleep 0.5
    #try_for(2) { expect(page_text).to include("Welcome, courtney. You are now signed in.") }
    expect(driver.find_element(:id, "navbar-login").displayed?).to eq(false)
    # TODO after login, the top 'Login' button
    shall_not_allow { driver.find_element(:id, "user-id") }      # TODO after login, shall redirect
    driver.find_element(:id, "navbar-logout").click
  end

  it "Login failed" do
    login("Steve", "test01")
    expect(page_text).to include("Username or password is invalid")  # TODO Missing error message
  end
end

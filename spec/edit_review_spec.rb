load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Edit Review" do
  include TestHelper

  before(:all) do
    # browser_type, browser_options, site_url are defined in test_helper.rb
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(1280, 720)
    driver.get(site_url)
        driver.find_element(:id, "navbar-login").click
    login("Courtney", "test01")

  end

  after(:all) do
    driver.quit unless debugging?
  end
  
  before(:each) do
  end

  it "Register user can update an review " do
   
  end
  
  
end

load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Search course" do
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

  it "Search course by code on home page" do
    # DESIGN
    # 1. enter a valid course code (in the top search box), such as COMP2048
    # 2. press the Enter key (on the search box elemement)
    # 3. verify the course name "Theory of Computing"
    
    # 4. Login
    driver.find_element(:id, "navbar-login").click
    login("Courtney", "test01")
    
    # 5. perform the same search with lower case
    # 6. verify
    # 7. Go back the home "/"
    # 8. Search an course does not exist
    # 9. Verify the "No course found"
    
  end
end

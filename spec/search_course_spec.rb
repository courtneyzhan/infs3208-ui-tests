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
    search_course("COMP2048")
    sleep 1
    expect(page_text).to include("Theory of Computing")

    driver.find_element(:id, "navbar-login").click
    login("Courtney", "test01")
    sleep 1
    
    search_course("comp2048")
    sleep 1
    expect(page_text).to include("Theory of Computing")

    visit("/")
    search_course("ius2048")
    sleep 1
    expect(page_text).to include("No course found")
  end
end

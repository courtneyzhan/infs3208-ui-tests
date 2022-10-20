load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Show Case " do
  include TestHelper

  before(:all) do
    # browser_type, browser_options, site_url are defined in test_helper.rb
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(1280, 720)
    driver.get(site_url)
    driver.find_element(:id, "navbar-login").click
    login("courtney", "test01")
  end

  after(:all) do
    driver.quit unless debugging?
  end

  before(:each) do
    click_nav_view_all_courses
  end
  
  # Running in normal mode, disable 'execution delay' and 'HighLight Control' 
  it "Show Case: Login, View List, Add a Review, Edit, Delete" do
    course_list_page = CourseListPage.new(driver)
    try_for(2) { course_list_page.click_course("CSSE2002") }
    
    course_page = CoursePage.new(driver)    
    course_page.delete_all_reviews
    try_for(4) { course_page.click_add_review }

    review_modal_page = ReviewModalPage.new(driver)
    review_modal_page.select_rating(5)
    review_modal_page.enter_comments("good course")
    review_modal_page.click_submit

    try_for(5) { expect(page_text).to include("good course") }
    
    driver.find_element(:xpath, "//button[text()='Edit']").click
    review_modal_page = ReviewModalPage.new(driver)
    review_modal_page.select_rating(5)
    review_modal_page.enter_comments("Very goood")
    review_modal_page.click_submit
    sleep 2 # say I about to delete it
    
    driver.find_element(:xpath, "//button[text()='Delete']").click
    sleep 1
  end

 
end

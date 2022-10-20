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
  
  # before edit, add review
  it "Register user can update an review " do
    click_nav_view_all_courses
    course_list_page = CourseListPage.new(driver)
    course_list_page.click_course("DECO2500")
    
    course_page = CoursePage.new(driver)    
    course_page.delete_all_reviews # clear all existing first, start clean
    try_for(4) { course_page.click_add_review } # if don't add specifc one, how can we verify

    review_modal_page = ReviewModalPage.new(driver)
    review_modal_page.select_rating(5)
    review_modal_page.enter_comments("to be changed soon")
    review_modal_page.click_submit
    
    course_page = CoursePage.new(driver)
    try_for(2) { course_page.click_edit }
    
    review_modal_page = ReviewModalPage.new(driver)
    expect(review_modal_page.current_rating).to eq("5")
    expect(review_modal_page.current_comments).to eq("to be changed soon")
    
    # now change it
    review_modal_page.select_rating(2)
    review_modal_page.enter_comments("Just changed it")
    review_modal_page.click_submit
    
    course_page = CoursePage.new(driver)
    expect(page_text).to include("Just changed it")
    expect(driver.find_element(:id, "overall-rating")["data-score"]).to eq("2")
  end
end

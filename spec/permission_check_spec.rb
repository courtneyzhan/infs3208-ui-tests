load File.dirname(__FILE__) + "/../test_helper.rb"

describe "User Permission Check" do
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

  it "Only user can submit review" do
    login("Courtney", "test01")

    click_nav_view_all_courses
    course_list_page = CourseListPage.new(driver)

    try_for(2) { course_list_page.click_course("CSSE1001") }
    
    course_page = CoursePage.new(driver)
    course_page.delete_all_reviews
    try_for(4) {  course_page.click_add_review }
    
    review_modal_page = ReviewModalPage.new(driver)
    review_modal_page.enter_comments("don't care")
    review_modal_page.click_submit
    logout

    click_nav_view_all_courses
    course_list_page = CourseListPage.new(driver)
    course_list_page.click_course("CSSE1001")
    
    expect(page_text).to include("You must be logged in to write a review for this course.")
  end
end

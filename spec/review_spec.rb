load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Review" do
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

  it "Add user review" do
    course_list_page = CourseListPage.new(driver)
    try_for(2) { course_list_page.click_course("COMP3506") }

    try_for(4) { driver.find_element(:id, "add-new-review-btn").click }
    sleep 0.5
    course_page = CoursePage.new(driver)
    course_page.select_rating(5)
    course_page.enter_comments("good course")
    course_page.click_submit
 
    try_for(5) { expect(page_text).to include("good course") }
  end

  it "Cannot add another review for the same course" do
    course_list_page = CourseListPage.new(driver)
    try_for(2) { course_list_page.click_course("CSSE1001") }

    course_page = CoursePage.new(driver)
    course_url = driver.current_url

    # delete tnhis course's all reviews first
    delete_count = driver.find_elements(:link_text, "Delete").count
    delete_count.times do
      driver.find_element(:link_text, "Delete").click
      sleep 0.5
      driver.get(course_url)
      sleep 0.5
    end

    driver.find_element(:id, "add-new-review-btn").click
    sleep 0.5

    course_page.select_rating(5)
    course_page.enter_comments("1st for 1001")
    course_page.click_submit
    sleep 1 # Could happen: immediately resubmitting the form, courseid not passed to server

    driver.find_element(:id, "add-new-review-btn").click
    sleep 0.5

    course_page = CoursePage.new(driver)
    course_page.select_rating(4)
    course_page.enter_comments("2nd for 1001")
    course_page.click_submit

    expect(page_text).not_to include("2nd for 1001")
  end
end

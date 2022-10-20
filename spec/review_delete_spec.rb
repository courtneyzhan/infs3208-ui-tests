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

  it "Delete an review" do
    course_list_page = CourseListPage.new(driver)
    try_for(2) { course_list_page.click_course("CYBR3000") }
    
    course_page = CoursePage.new(driver)    
    course_page.delete_all_reviews
    try_for(4) { course_page.click_add_review }

    review_modal_page = ReviewModalPage.new(driver)
    review_modal_page.select_rating(1)
    review_modal_page.enter_comments("Will be deleted soon")
    review_modal_page.click_submit
    
    sleep 1
    #TODO refactor to page
    course_page.click_delete
    expect(driver.find_element(:id, "num-reviews").text).to eq("(0)")
  end

end

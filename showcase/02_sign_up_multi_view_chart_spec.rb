load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Show Case " do
  include TestHelper

  before(:all) do
    # browser_type, browser_options, site_url are defined in test_helper.rb
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(390, 844) # iphone 12
    driver.get(site_url)
    driver.find_element(:xpath, "//a[@aria-label='menu']").click
    sleep 0.5
    driver.find_element(:id, "navbar-login").click
    login("courtney", "test01")
  end

  after(:all) do
    driver.quit unless debugging?
  end

  before(:each) do
    sleep 0.5
  end

  # !! Running in normal mode, disable 'execution delay' and 'HighLight Control'
  it "Show Case: Mobile format: Search Course, Add a Review, Edit, Delete" do
    driver.find_element(:xpath, "//a[@aria-label='menu']").click
    sleep 1
    search_course("INFS3208")

    course_page = CoursePage.new(driver)
    course_page.delete_all_reviews # deletes own reviews
    course_url = driver.current_url
    try_for(4) { course_page.click_add_review }

    review_modal_page = ReviewModalPage.new(driver)
    #review_modal_page.select_rating(3) # default rating
    review_modal_page.enter_comments("good course")
    review_modal_page.click_submit

    try_for(5) { expect(page_text).to include("good course") }

    driver.find_element(:xpath, "//a[@aria-label='menu']").click
    sleep 0.5
    logout

    driver.find_element(:xpath, "//a[@aria-label='menu']").click
    sleep 0.5
    driver.find_element(:id, "navbar-signup").click
    new_user_name = "test" + Faker::Number.number(digits: 6).to_s

    sign_up_page = SignUpPage.new(driver)
    sign_up_page.enter_username(new_user_name)
    sign_up_page.enter_password("test01")
    sign_up_page.enter_password_confirmation("test01")
    sign_up_page.click_sign_up_button
    sleep 1.5
    
    login(new_user_name, "test01")
    sleep 0.5
    puts "go to course: #{course_url}"
    driver.get(course_url)

    course_page = CoursePage.new(driver)
    try_for(4) { course_page.click_add_review }

    review_modal_page = ReviewModalPage.new(driver)
    review_modal_page.select_rating([1, 2, 3, 4, 5].sample)
    review_modal_page.enter_comments("Average")
    review_modal_page.click_submit

    driver.find_element(:id, "votes").click
    sleep 1
  end
end

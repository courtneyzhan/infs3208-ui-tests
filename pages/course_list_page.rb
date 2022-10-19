require File.join(File.dirname(__FILE__), "abstract_page.rb")

class CourseListPage < AbstractPage
  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def click_course(course_id)
    driver.find_element(:xpath, "//span[text()='#{course_id}']").click
    sleep 0.25
  end
end

require File.join(File.dirname(__FILE__), "abstract_page.rb")

class CoursePage < AbstractPage
  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def click_add_review
    driver.find_element(:id, "add-new-review-btn").click
    sleep 0.5
  end

  # a helper for testing, delete tnhis course's all reviews first
  def delete_all_reviews
    sleep 1
    delete_count = driver.find_elements(:xpath, "//button[text()='Delete']").count
    puts("Delete existing reviews: #{delete_count}")
    delete_count.times do
      driver.find_element(:xpath, "//button[text()='Delete']").click
      sleep 0.5
    end
  end
end

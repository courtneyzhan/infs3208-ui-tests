
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class CoursePage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
    sleep 0.5
  end
  
  # only care > 3, change later
  # default is 3
  def select_rating(the_rating)
    elem = driver.find_element(:id, "review-rating")
    (5 - the_rating).times do 
      driver.find_element(:id, "review-rating").send_keys(:right)
      end
  end


  def enter_comments(reviewcomments)
    driver.find_element(:id, "review-comments").send_keys(reviewcomments)
  end
  def click_submit
    driver.find_element(:id, "new-review-btn").click
    sleep 1
  end
end



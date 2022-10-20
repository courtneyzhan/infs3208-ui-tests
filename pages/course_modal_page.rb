require File.join(File.dirname(__FILE__), "abstract_page.rb")

class ReviewModalPage < AbstractPage
  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
    sleep 0.5
  end

  # only care > 3, change later
  # default is 3
  # TODO: support 1 and 2
  def select_rating(the_rating)
    sleep 0.1
    elem = driver.find_element(:id, "review-rating")
    (the_rating - 3).times do
      puts("Move right ...")
      driver.find_element(:id, "review-rating").send_keys(:right)
      sleep 0.2
    end
  end

  def enter_comments(reviewcomments)
    elem = driver.find_element(:id, "review-comments")
    elem.clear
    elem.send_keys(reviewcomments)
  end

  def click_submit
    driver.find_element(:id, "new-review-btn").click
    sleep 1
  end

  def modal_text
    driver.find_element(:id, "modal-review").text
  end
end

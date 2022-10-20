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
=begin # too slow    
    5.times { elem.send_keys(:left) }
    (the_rating - 1).times do
      driver.find_element(:id, "review-rating").send_keys(:right)
      sleep 0.2
    end
=end

    elem.clear # reset to 3
    if the_rating >= 3
      (the_rating - 3).times do
        puts("Move right ...")
        driver.find_element(:id, "review-rating").send_keys(:right)
        sleep 0.2
      end
    else
      (3 - the_rating).times do
        puts("Move left ...")
        driver.find_element(:id, "review-rating").send_keys(:left)
        sleep 0.2
      end
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

  def current_rating
    driver.find_element(:id, "review-rating")["value"]
  end

  def current_comments
    driver.find_element(:id, "review-comments")["value"]
  end
end

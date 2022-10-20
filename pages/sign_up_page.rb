
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class SignUpPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_username(new_user_name)
    driver.find_element(:id, "login").send_keys(new_user_name)
  end

  def enter_password(password)
    driver.find_element(:id, "password").send_keys(password)
  end


  def enter_password_confirmation(password_confirmation)
    driver.find_element(:id, "password_confirmation").send_keys(password_confirmation)
  end


  def click_sign_up_button
    driver.find_element(:id, "signup-btn").click
    sleep 0.5
  end
end









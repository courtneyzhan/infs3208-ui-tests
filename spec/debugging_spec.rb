# Special test that uses last browser window (from a TestWise run)
# Then you can try Selenium commands directly on the page, without the need to restart from the beginning.

load File.dirname(__FILE__) + "/../test_helper.rb"

describe "DEBUG" do
  include TestHelper

  before(:all) do
    use_current_browser
  end

  it "Debugging" do
  puts driver.find_element(:id, "overall-rating")["data-score"]
  end
end

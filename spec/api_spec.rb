load File.dirname(__FILE__) + "/../test_helper.rb"
require "rest-client"

describe "API" do
  include TestHelper

  before(:all) do
    @backend_server_url = site_url + ":3000"
  end

  after(:all) do
  end

  def get_json_response(path)
    api_url = @backend_server_url + path
    json_response = RestClient.get api_url
    puts json_response
    json_obj = JSON.parse(json_response)
  end

  it "Get user detail" do
    json_obj = get_json_response("/users/1.json")
    expect(json_obj["login"]).to eq("stevie")
  end

  it "Get course detail" do
    json_obj = get_json_response "/courses/1.json"
    expect(json_obj["course_code"]).to eq("COMP2048")
  end
end

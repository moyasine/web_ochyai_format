require 'test_helper'

class GenerateFormatControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get generate_format_index_url
    assert_response :success
  end

end

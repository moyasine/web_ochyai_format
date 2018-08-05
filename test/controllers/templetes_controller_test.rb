require 'test_helper'

class TempletesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get templetes_index_url
    assert_response :success
  end

  test "should get new" do
    get templetes_new_url
    assert_response :success
  end

  test "should get create" do
    get templetes_create_url
    assert_response :success
  end

end

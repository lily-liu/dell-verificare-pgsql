require 'test_helper'

class VisibilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @visibility = visibilities(:one)
  end

  test "should get index" do
    get visibilities_url, as: :json
    assert_response :success
  end

  test "should create visibility" do
    assert_difference('Visibility.count') do
      post visibilities_url, params: { visibility: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show visibility" do
    get visibility_url(@visibility), as: :json
    assert_response :success
  end

  test "should update visibility" do
    patch visibility_url(@visibility), params: { visibility: {  } }, as: :json
    assert_response 200
  end

  test "should destroy visibility" do
    assert_difference('Visibility.count', -1) do
      delete visibility_url(@visibility), as: :json
    end

    assert_response 204
  end
end

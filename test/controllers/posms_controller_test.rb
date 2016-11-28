require 'test_helper'

class PosmsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @posm = posms(:one)
  end

  test "should get index" do
    get posms_url, as: :json
    assert_response :success
  end

  test "should create posm" do
    assert_difference('Posm.count') do
      post posms_url, params: {posms: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show posm" do
    get posm_url(@posm), as: :json
    assert_response :success
  end

  test "should update posm" do
    patch posm_url(@posm), params: {posms: {  } }, as: :json
    assert_response 200
  end

  test "should destroy posm" do
    assert_difference('Posm.count', -1) do
      delete posm_url(@posm), as: :json
    end

    assert_response 204
  end
end

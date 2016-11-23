require 'test_helper'

class SelloutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sellout = sellouts(:one)
  end

  test "should get index" do
    get sellouts_url, as: :json
    assert_response :success
  end

  test "should create sellout" do
    assert_difference('Sellout.count') do
      post sellouts_url, params: { sellout: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show sellout" do
    get sellout_url(@sellout), as: :json
    assert_response :success
  end

  test "should update sellout" do
    patch sellout_url(@sellout), params: { sellout: {  } }, as: :json
    assert_response 200
  end

  test "should destroy sellout" do
    assert_difference('Sellout.count', -1) do
      delete sellout_url(@sellout), as: :json
    end

    assert_response 204
  end
end

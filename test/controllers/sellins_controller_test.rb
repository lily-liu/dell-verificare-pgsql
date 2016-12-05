require 'test_helper'

class SellinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sellin = sellins(:one)
  end

  test "should get index" do
    get sellins_url, as: :json
    assert_response :success
  end

  test "should create sellin" do
    assert_difference('Sellin.count') do
      post sellins_url, params: { sellin: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show sellin" do
    get sellin_url(@sellin), as: :json
    assert_response :success
  end

  test "should update sellin" do
    patch sellin_url(@sellin), params: { sellin: {  } }, as: :json
    assert_response 200
  end

  test "should destroy sellin" do
    assert_difference('Sellin.count', -1) do
      delete sellin_url(@sellin), as: :json
    end

    assert_response 204
  end
end

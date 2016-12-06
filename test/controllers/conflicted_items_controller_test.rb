require 'test_helper'

class ConflictedItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @conflicted_item = conflicted_items(:one)
  end

  test "should get index" do
    get conflicted_items_url, as: :json
    assert_response :success
  end

  test "should create conflicted_item" do
    assert_difference('ConflictedItem.count') do
      post conflicted_items_url, params: { conflicted_item: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show conflicted_item" do
    get conflicted_item_url(@conflicted_item), as: :json
    assert_response :success
  end

  test "should update conflicted_item" do
    patch conflicted_item_url(@conflicted_item), params: { conflicted_item: {  } }, as: :json
    assert_response 200
  end

  test "should destroy conflicted_item" do
    assert_difference('ConflictedItem.count', -1) do
      delete conflicted_item_url(@conflicted_item), as: :json
    end

    assert_response 204
  end
end

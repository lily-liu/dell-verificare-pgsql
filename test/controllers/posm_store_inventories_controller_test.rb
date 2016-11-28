require 'test_helper'

class PosmStoreInventoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @posm_store_inventory = posm_store_inventories(:one)
  end

  test "should get index" do
    get posm_store_inventories_url, as: :json
    assert_response :success
  end

  test "should create posm_store_inventory" do
    assert_difference('PosmStoreInventory.count') do
      post posm_store_inventories_url, params: { posm_store_inventory: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show posm_store_inventory" do
    get posm_store_inventory_url(@posm_store_inventory), as: :json
    assert_response :success
  end

  test "should update posm_store_inventory" do
    patch posm_store_inventory_url(@posm_store_inventory), params: { posm_store_inventory: {  } }, as: :json
    assert_response 200
  end

  test "should destroy posm_store_inventory" do
    assert_difference('PosmStoreInventory.count', -1) do
      delete posm_store_inventory_url(@posm_store_inventory), as: :json
    end

    assert_response 204
  end
end

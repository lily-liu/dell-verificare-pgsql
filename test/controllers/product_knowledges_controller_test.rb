require 'test_helper'

class ProductKnowledgesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sell_kit = product_knowledges(:one)
  end

  test "should get index" do
    get product_knowledges_url, as: :json
    assert_response :success
  end

  test "should create product_knowledge" do
    assert_difference('ProductKnowledge.count') do
      post product_knowledges_url, params: {sell_kit: {description: @sell_kit.description, file_name: @sell_kit.file_name, name: @sell_kit.name } }, as: :json
    end

    assert_response 201
  end

  test "should show product_knowledge" do
    get product_knowledge_url(@sell_kit), as: :json
    assert_response :success
  end

  test "should update product_knowledge" do
    patch product_knowledge_url(@sell_kit), params: {sell_kit: {description: @sell_kit.description, file_name: @sell_kit.file_name, name: @sell_kit.name } }, as: :json
    assert_response 200
  end

  test "should destroy product_knowledge" do
    assert_difference('ProductKnowledge.count', -1) do
      delete product_knowledge_url(@sell_kit), as: :json
    end

    assert_response 204
  end
end

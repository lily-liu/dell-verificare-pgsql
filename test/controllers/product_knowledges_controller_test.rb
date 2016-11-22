require 'test_helper'

class ProductKnowledgesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_knowledge = product_knowledges(:one)
  end

  test "should get index" do
    get product_knowledges_url, as: :json
    assert_response :success
  end

  test "should create product_knowledge" do
    assert_difference('ProductKnowledge.count') do
      post product_knowledges_url, params: { product_knowledge: { description: @product_knowledge.description, file_name: @product_knowledge.file_name, name: @product_knowledge.name } }, as: :json
    end

    assert_response 201
  end

  test "should show product_knowledge" do
    get product_knowledge_url(@product_knowledge), as: :json
    assert_response :success
  end

  test "should update product_knowledge" do
    patch product_knowledge_url(@product_knowledge), params: { product_knowledge: { description: @product_knowledge.description, file_name: @product_knowledge.file_name, name: @product_knowledge.name } }, as: :json
    assert_response 200
  end

  test "should destroy product_knowledge" do
    assert_difference('ProductKnowledge.count', -1) do
      delete product_knowledge_url(@product_knowledge), as: :json
    end

    assert_response 204
  end
end

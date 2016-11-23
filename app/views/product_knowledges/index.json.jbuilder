json.status "success"
json.message "product_knowledges"
json.data do
  json.array! @product_knowledges, partial: 'product_knowledges/product_knowledge', as: :product_knowledge
end

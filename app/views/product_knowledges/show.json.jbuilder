json.status "success"
json.message "product_knowledge"
json.data do
  json.partial! "product_knowledges/product_knowledge", product_knowledge: @product_knowledge
end

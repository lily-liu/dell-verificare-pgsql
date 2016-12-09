json.status "success"
json.message "posm_inventory"
json.data do
  json.array! @posm_store_inventories, partial: 'posm_store_inventories/posm_store_inventory', as: :posm_store_inventory
end

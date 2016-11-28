json.status "success"
json.message "posm inventory"
json.data do
  json.partial! "posm_store_inventories/posm_store_inventory", posm_store_inventory: @posm_store_inventory
end

json.status "success"
json.message "inventory"
json.data do
  json.array! @inventories, partial: 'inventories/inventory', as: :inventory
end
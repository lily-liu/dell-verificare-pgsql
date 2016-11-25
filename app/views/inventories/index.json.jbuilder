json.status "success"
json.message "inventory"
json.data do
  json.array! @inventory, partial: 'inventories/inventory', as: :inventory
end
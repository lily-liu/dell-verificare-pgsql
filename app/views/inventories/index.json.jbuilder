json.status "success"
json.message "inventory"
json.totalData @total
json.data do
  json.array! @inventories, partial: 'inventories/inventory', as: :inventory
end
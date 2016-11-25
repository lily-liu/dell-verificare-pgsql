json.status "success"
json.message "inventory"
json.data do
  json.partial! "inventories/inventory", inventory: @inventory
end
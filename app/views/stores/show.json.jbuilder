json.status "success"
json.message "store"
json.data do
  json.partial! "stores/store", store: @store
end
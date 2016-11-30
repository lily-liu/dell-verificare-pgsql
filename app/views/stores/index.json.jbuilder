json.status "success"
json.message "store"
json.data do
  json.array! @stores, partial: 'stores/store', as: :store
end
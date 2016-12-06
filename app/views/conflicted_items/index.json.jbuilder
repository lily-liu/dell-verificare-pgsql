json.status "success"
json.message "conflict"
json.data do
  json.array! @conflicted_items, partial: 'conflicted_items/conflicted_item', as: :conflicted_item
end
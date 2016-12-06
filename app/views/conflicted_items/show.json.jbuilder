json.status "success"
json.message "conflict"
json.data do
  json.partial! "conflicted_items/conflicted_item", conflicted_item: @conflicted_item
end
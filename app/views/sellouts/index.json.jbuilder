json.status "success"
json.message "sellouts"
json.totalSellins @total
json.data do
  json.array! @sellouts, partial: 'sellouts/sellout', as: :sellout
end
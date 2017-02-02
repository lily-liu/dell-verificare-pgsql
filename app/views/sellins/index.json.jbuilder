json.status "success"
json.message "sellin"
json.draw @draw
json.prev @draw - 1
json.next @draw + 1
json.recordsTotal 100
json.recordsFiltered 100
json.data do
    json.array! @sellins, partial: 'sellins/sellin', as: :sellin
end
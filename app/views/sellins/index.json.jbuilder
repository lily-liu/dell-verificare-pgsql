json.status "success"
json.message "sellin"
json.data do
    json.array! @sellins, partial: 'sellins/sellin', as: :sellin
end
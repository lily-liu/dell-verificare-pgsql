json.data do
    json.array! @sellins, partial: 'sellins/sellin', as: :sellin
end
json.draw @draw.to_s
json.recordsTotal 100
json.recordsFiltered 100
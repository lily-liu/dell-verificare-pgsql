json.status "success"
json.message "region"
json.data do
  json.array! @regions, partial: 'regions/region', as: :region
end
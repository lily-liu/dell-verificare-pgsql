json.status "success"
json.message "region"
json.data do
  json.array! @regions, partial: 'regions/egion', as: :region
end
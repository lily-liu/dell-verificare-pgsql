json.status "success"
json.message "city"
json.data do
  json.array! @cities, partial: 'cities/city', as: :city
end
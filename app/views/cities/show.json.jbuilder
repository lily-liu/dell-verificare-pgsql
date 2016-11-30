json.status "success"
json.message "city"
json.data do
  json.partial! "cities/city", city: @city
end
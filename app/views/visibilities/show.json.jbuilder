json.status "success"
json.message "visibility"
json.data do
  json.partial! "visibilities/visibility", visibility: @visibility
end
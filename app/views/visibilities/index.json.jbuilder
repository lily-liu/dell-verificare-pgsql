json.status "success"
json.message "visibility"
json.data do
  json.array! @visibilities, partial: 'visibilities/visibility', as: :visibility
end
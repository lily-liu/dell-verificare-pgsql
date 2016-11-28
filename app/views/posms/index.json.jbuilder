json.status "success"
json.message "posm"
json.data do
  json.array! @posms, partial: 'posms/posm', as: :posm
end

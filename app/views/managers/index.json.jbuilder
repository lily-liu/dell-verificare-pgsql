json.status "success"
json.message "manager"
json.data do
  json.array! @managers, partial: 'managers/manager', as: :manager
end

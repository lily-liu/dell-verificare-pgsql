json.status "success"
json.message "manager"
json.data do
  json.partial! "managers/manager", manager: @manager
end

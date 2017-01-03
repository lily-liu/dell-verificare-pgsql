json.status "success"
json.message "sellout"
json.data do
  json.failed @stores.failed_instances
  json.success @success_input
end
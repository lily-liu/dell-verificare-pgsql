json.status "success"
json.message "city"
json.data do
  json.failed @cities.failed_instances
  json.success @success_input
end
json.status "success"
json.message "user"
json.data do
  json.failed @users.failed_instances
  json.success @success_input
end
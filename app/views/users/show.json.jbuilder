json.status "success"
json.message "user"
json.data do
  json.partial! "users/user", user: @user
end
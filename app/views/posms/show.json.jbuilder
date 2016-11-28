json.status "success"
json.message "posm"
json.data do
  json.partial! "posms/posm", posm: @posm
end

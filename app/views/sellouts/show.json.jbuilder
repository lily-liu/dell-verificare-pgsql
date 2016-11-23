json.status "success"
json.message "sellout"
json.data do
  json.partial! "sellouts/sellout", sellout: @sellout
end
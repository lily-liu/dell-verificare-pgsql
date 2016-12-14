json.status "success"
json.message "recap_inventories"
json.data do
  json.label @report.keys
  json.value @report.values
end
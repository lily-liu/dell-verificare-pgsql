json.status "success"
json.message "recap_posm"
json.data do
  json.label @report.keys
  json.value @report.values
end
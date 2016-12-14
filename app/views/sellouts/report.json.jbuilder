json.status "success"
json.message "recap_sellouts"
json.data do
  json.label @report.keys
  json.value @report.values
end
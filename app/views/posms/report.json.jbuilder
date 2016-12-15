json.status "success"
json.message "recap_posm"
json.data do
  json.label @categories
  json.value @report.values
end
json.status "success"
json.message "absence"
json.data do
  json.partial! "absences/absence", absence: @absence
end
json.status "success"
json.message "absences"
json.data do
  json.array! @absences, partial: 'absences/absence', as: :absence
end
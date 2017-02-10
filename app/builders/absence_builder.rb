class AbsenceBuilder < Julia::Builder
  column 'Username', :username
  column 'Store Name', :name
  column 'Absence Type', :absence_type
  column 'Remark', :remark
  column 'Absence Time', :created_at
end
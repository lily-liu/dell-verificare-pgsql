class AbsenceBuilder < Julia::Builder
  asd = :created_at
  column 'Username', :username
  column 'Store Name', :name
  column 'Absence Type', :absence_type
  column 'Absence Date', -> { "#{created_at.to_date}" }
  column 'Absence Time', -> { "#{created_at.to_time.getlocal("+07:00")}" }
end
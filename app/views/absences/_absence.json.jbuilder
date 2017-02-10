json.extract! absence, :id, :user, :absence_type, :created_at, :store
json.location "#{absence.latitude},#{absence.longitude}"
# json.url absence_url(absence, format: :json)
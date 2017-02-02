json.extract! post, :id, :title, :content, :user, :level, :created_at
json.notif @push_response
#json.url post_url(post, format: :json)

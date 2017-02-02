json.extract! post, :id, :title, :content, :user, :parent, :level, :comments, :created_at
json.notif @push_response
#json.url post_url(post, format: :json)

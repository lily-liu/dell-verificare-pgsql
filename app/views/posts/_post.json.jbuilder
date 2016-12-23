json.extract! post, :id, :title, :content, :user, :parent, :level, :comments
json.notif @push_response
#json.url post_url(post, format: :json)

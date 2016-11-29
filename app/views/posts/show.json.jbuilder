json.status "success"
json.message "post"
json.data do
  json.partial! "posts/post", post: @post
end

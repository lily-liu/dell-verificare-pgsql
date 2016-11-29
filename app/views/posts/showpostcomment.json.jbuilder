json.status "success"
json.message "post"
json.data do
  json.partial! "posts/postcomment", post_comment: @post_comment
end

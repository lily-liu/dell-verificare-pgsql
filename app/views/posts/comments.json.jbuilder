json.status "success"
json.message "post"
json.data do
  json.post do
    json.partial! "posts/post", post: @post
  end
  json.comments do
    json.array! @comments, partial: 'posts/comment-partial', as: :comment
  end
end

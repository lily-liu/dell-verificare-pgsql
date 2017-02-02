json.status "success"
json.message "post"
json.data json.array do
  json.array! @posts, partial: 'posts/post', as: :post
end

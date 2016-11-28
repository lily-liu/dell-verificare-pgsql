json.status "success"
json.message "post"
json.data do
  json.array! @posts, partial: 'posts/post', as: :post
end

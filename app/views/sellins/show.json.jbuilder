json.status "success"
json.message "sellin"
json.data do
    json.partial! "sellins/sellin", sellin: @sellin
end
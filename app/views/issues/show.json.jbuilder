json.status "success"
json.message "issue"
json.data do
  json.partial! "issues/issue", issue: @issue
end

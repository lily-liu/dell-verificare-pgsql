json.status "success"
json.message "sell_kit"
json.data do
  json.partial! "sell_kits/sell_kit", sell_kit: @sell_kit
end

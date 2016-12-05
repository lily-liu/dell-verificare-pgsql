json.status "success"
json.message "sell_kit"
json.data do
  json.array! @sell_kits, partial: 'sell_kits/sell_kit', as: :sell_kit
end

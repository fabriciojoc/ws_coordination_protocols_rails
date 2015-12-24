json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :product_name, :price, :card_number
  json.url purchase_url(purchase, format: :json)
end

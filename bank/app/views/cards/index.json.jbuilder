json.array!(@cards) do |card|
  json.extract! card, :id, :number, :expiration_date, :security_code, :password
  json.url card_url(card, format: :json)
end

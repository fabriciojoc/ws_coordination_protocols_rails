json.array!(@accounts) do |account|
  json.extract! account, :id, :agency, :account, :password, :balance
  json.url account_url(account, format: :json)
end

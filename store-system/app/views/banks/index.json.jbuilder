json.array!(@banks) do |bank|
  json.extract! bank, :id, :name, :wsdl_location
  json.url bank_url(bank, format: :json)
end

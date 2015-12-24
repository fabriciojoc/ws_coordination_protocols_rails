json.array!(@providers) do |provider|
  json.extract! provider, :id, :name, :description, :wsdl_location
  json.url provider_url(provider, format: :json)
end

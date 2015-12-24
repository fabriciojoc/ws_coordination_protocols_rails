json.array!(@holders) do |holder|
  json.extract! holder, :id, :name, :cpf
  json.url holder_url(holder, format: :json)
end

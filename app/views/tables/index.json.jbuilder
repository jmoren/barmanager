json.array!(@tables) do |table|
  json.extract! table, :id, :number
  json.url table_url(table, format: :json)
end

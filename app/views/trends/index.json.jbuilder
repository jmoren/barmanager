json.array!(@trends) do |trend|
  json.extract! trend, :id, :name, :description, :address, :city, :country, :phone, :email
  json.url trend_url(trend, format: :json)
end

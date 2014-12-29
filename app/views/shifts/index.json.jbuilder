json.array!(@shifts) do |shift|
  json.extract! shift, :id, :open, :close
  json.url shift_url(shift, format: :json)
end

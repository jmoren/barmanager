json.array!(@cancel_reasons) do |cancel_reason|
  json.extract! cancel_reason, :id, :text
  json.url cancel_reason_url(cancel_reason, format: :json)
end

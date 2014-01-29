json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :trend_id, :table_id, :date, :total, :payment
  json.url ticket_url(ticket, format: :json)
end

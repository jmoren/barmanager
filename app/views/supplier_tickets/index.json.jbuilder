json.array!(@supplier_tickets) do |supplier_ticket|
  json.extract! supplier_ticket, :id, :amount, :supplier_id, :shift_id
  json.url supplier_ticket_url(supplier_ticket, format: :json)
end

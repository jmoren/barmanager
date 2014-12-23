json.array!(@item_tickets) do |item_ticket|
  json.extract! item_ticket, :id, :ticket_id, :item_id, :quantity, :sub_total
  json.url item_ticket_url(item_ticket, format: :json)
end

json.array!(@promotions) do |promotion|
  json.extract! promotion, :id, :items_id
  json.url promotion_url(promotion, format: :json)
end

class StatisticsController < ApplicationController
  def index
    if params[:date]
      selected_date = Date.parse(params[:date])
      date  = selected_date.beginning_of_day..selected_date.end_of_day
      @tickets  = Ticket.where(created_at: date)
      @total    = @tickets.sum(:total)
      item_tickets = ItemTicket.where(ticket_id: @tickets.map(&:id))
      @by_items = {}
      item_tickets.each do |it|
        item = it.item
        if item
          @by_items[item.description] = 0 if @by_items[item.description].nil?
          @by_items[item.description] += it.quantity
        end
      end
    else
      @tickets = Ticket.all
      @total   = @tickets.sum(:total)
      @by_items = {}
      ItemTicket.all.each do |it|
        item = it.item
        if item
          @by_items[item.description] = 0 if @by_items[item.description].nil?
          @by_items[item.description] += it.quantity
        end
      end
    end
  end
end

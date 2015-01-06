class HomeController < ApplicationController
  def index
    @tickets = Ticket.all
    @total   = @tickets.sum(:total)
    @by_items = {}
    ItemTicket.all.each do |it|
      item = it.item
      @by_items[item.description] = 0 if @by_items[item.description].nil?
      @by_items[item.description] += it.quantity
    end
  end
end

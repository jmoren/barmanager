class KitchenController < ApplicationController

  def index
    items = Table.open.map(&:kitchen_item_tickets).flatten.compact
    promotions = Table.open.map(&:kitchen_promotion_tickets).flatten.compact

    @kitchen_items = items | promotions

    @kitchen_items.sort{ |x,y| y.created_at <=> x.created_at }

  end

  def show
    ticket = Ticket.find(params[:ticket_id])

    @table = ticket.table.name

    @current_ticket = ticket

    if (params[:type] === "item")
      @items_tickets = ticket.item_tickets.where(item_id: params[:item_id])
      render :show_items, layout: false
    else
      @promo_tickets = ticket.promotion_tickets.where(promotion_id: params[:item_id])
      render :show_promos, layout: false
    end
  end
end
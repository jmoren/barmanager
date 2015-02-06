class KitchenController < ApplicationController
  layout "admin"
  def index
    items               = Table.open.map(&:kitchen_item_tickets).flatten.compact
    promotions          = Table.open.map(&:kitchen_promotion_tickets).flatten.compact
    items_to_carry      = Ticket.without_table.where(status: :open).map(&:item_tickets_to_kitchen).flat.compact
    promotions_to_carry = Ticket.without_table.where(status: :open).map(&:promotion_tickets_to_kitchen)
    @kitchen_items = (items | promotions | items_to_carry | promotions_to_carry).flatten.compact

    @kitchen_items.sort{ |x,y| y.created_at <=> x.created_at }

  end

  def show
    @current_ticket = Ticket.find(params[:ticket_id])
    @table = @current_ticket.table

    if (params[:type] === "item")
      @items_tickets = @current_ticket.item_tickets.where(item_id: params[:item_id])
      render :show_items, layout: false
    else
      @promo_tickets = @current_ticket.promotion_tickets.where(promotion_id: params[:item_id])
      render :show_promos, layout: false
    end
  end

  def print_table
    @current_ticket = Ticket.find(params[:ticket_id])

    @item_tickets = @current_ticket.item_tickets_to_kitchen.where(delivered: false)
    @promo_tickets = @current_ticket.promotion_tickets_to_kitchen.map { |pt| pt if !pt.full_delivered? }

    @additionals = @current_ticket.additionals.where(delivered: false, kitchen: true)
    @kitchen_items = (@item_tickets | @promo_tickets)

    render :index, layout: false
  end
end

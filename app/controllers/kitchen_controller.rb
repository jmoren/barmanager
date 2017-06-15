class KitchenController < ApplicationController
  layout "admin"
  def index
    @tickets     = Ticket.where(status: 'open').sort {|a,b| a.first_kitchen_item <=> b.first_kitchen_item}

    items        = @tickets.map(&:item_tickets_to_kitchen).flatten.compact
    promotions   = @tickets.map(&:promotion_tickets_to_kitchen).flatten.compact
    @additionals = @tickets.map(&:additionals_to_kitchen).flatten.compact.group_by { |ki| ki.ticket_id }
    @kitchen_items = (items | promotions).flatten.compact

    @kitchen_items = @kitchen_items.group_by { |ki| ki.ticket_id }
    tickets_ids = (items.map(&:ticket_id) | promotions.map(&:ticket_id) | @additionals.map(&:ticket_id)).flatten.compact.uniq

    @tickets = @tickets.select { |t| tickets_ids.include? t.id }


    if current_user.is_cooker?
      render layout: "kitchen"
    end
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
    render :print_table, layout: false
  end
end

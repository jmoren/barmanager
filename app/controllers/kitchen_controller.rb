class KitchenController < ApplicationController
  layout "admin"
  def index
    its = ItemTicket.where("item_tickets.created_at > ?", 1.days.ago).pending_kitchen.group_by(&:ticket)

    pts =  PromotionTicketItem.where("promotion_tickets.created_at > ?", 1.days.ago).pending_kitchen.group_by(&:ticket)

    ats = Additional.where("additionals.created_at > ?", 1.days.ago).pending_kitchen.group_by(&:ticket)

    @kitchen_items = its.merge!(pts){|k, o, n| o | n }.merge!(ats){|k, o, n| o | n }.sort { |a , b| a.first.first_kitchen_item <=> b.first.first_kitchen_item}

    if current_user.is_cooker?
      render layout: "kitchen"
    end
  end

  def check_update
    last_render = params[:last_render]

    last_item = ItemTicket.where("item_tickets.created_at > ?", 1.days.ago).pending_kitchen.last.try(:created_at) || last_render
    last_promo = PromotionTicketItem.where("promotion_tickets.created_at > ?", 1.days.ago).pending_kitchen.last.try(:promotion_ticket).try(:created_at) || last_render
    last_add = Additional.where("additionals.created_at > ?", 1.days.ago).pending_kitchen.last.try(:created_at) || last_render


    last_item_date = [last_item, last_promo, last_add].max

    render json: { should_render: last_render.to_datetime < last_item_date ? true : false }

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

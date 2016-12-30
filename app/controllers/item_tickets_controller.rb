class ItemTicketsController < ApplicationController
  before_action :set_ticket
  before_action :set_item_ticket, only: [:destroy, :deliver]

  def create
    @item_ticket = @ticket.item_tickets.new(item_ticket_params)
    @item_ticket.save
    redirect_to @ticket
  end

  def bulk
    params[:item_ticket].each do |it|
      @ticket.item_tickets.new(item_id: it["item_id"], quantity: it["quantity"]) unless it["item_id"].empty? || it["quantity"].empty?
    end
    @ticket.save
    redirect_to @ticket
  end

  def destroy
    @item_ticket.destroy
    redirect_to @ticket
  end

  def deliver
    @item_ticket.update(delivered: true)
    redirect_to :back
  end

  def destroy_all
    @ticket.item_tickets.where(item_id: params[:item_id]).destroy_all
    redirect_to @ticket
  end

  def increase
    new_item_ticket = @ticket.item_tickets.where(item_id: params[:id]).last.dup
    new_item_ticket.quantity = 1
    new_item_ticket.delivered = false
    new_item_ticket.save
    redirect_to @ticket
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def set_item_ticket
      @item_ticket = ItemTicket.find(params[:id])
    end

    def item_ticket_params
      params.require(:item_ticket).permit(:ticket_id, :item_id, :quantity, :sub_total)
    end
end

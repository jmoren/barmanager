class ItemTicketsController < ApplicationController
  before_action :set_ticket
  before_action :set_item_ticket, only: [:destroy, :deliver]

  def create
    @item_ticket = @ticket.item_tickets.new(item_ticket_params)
    @item_ticket.save
    dest = @item_ticket.ticket.table || @item_ticket.ticket
    redirect_to dest
  end

  def destroy
    dest = @item_ticket.ticket.table || @item_ticket.ticket
    @item_ticket.destroy
    redirect_to dest
  end

  def deliver
    @item_ticket.update(delivered: true)
    redirect_to :back
  end

  def destroy_all
    dest = @ticket.table || @ticket

    @ticket.item_tickets.where(item_id: params[:item_id]).destroy_all

    redirect_to dest
  end

  def increase
    new_item_ticket = @ticket.item_tickets.where(item_id: params[:id]).last.dup
    table = @ticket.table
    new_item_ticket.quantity = 1
    new_item_ticket.delivered = false
    new_item_ticket.save
    redirect_to table.nil? ? @ticket : table
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

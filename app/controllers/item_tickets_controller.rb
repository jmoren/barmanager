class ItemTicketsController < ApplicationController
  before_action :set_ticket
  before_action :set_item_ticket, only: [:destroy]
  
  def create
    @item_ticket = @ticket.item_tickets.new(item_ticket_params)
    @item_ticket.save
    redirect_to @item_ticket.ticket.table
  end

  def destroy
    table = @item_ticket.ticket.table
    @item_ticket.destroy
    redirect_to table
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

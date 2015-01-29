class ItemTicketsController < ApplicationController
  before_action :set_ticket
  before_action :set_item_ticket, only: [:destroy, :increase, :decrease]

  def create

    @item_ticket = @ticket.item_tickets.new(item_ticket_params)

    existent_item_ticket = @ticket.item_tickets.where(item_id: @item_ticket.item_id).first
    if existent_item_ticket
      existent_item_ticket.quantity += @item_ticket.quantity
      existent_item_ticket.save
    else
      @item_ticket.save
    end
    redirect_to @ticket.table
  end

  def destroy
    table = @item_ticket.ticket.table
    @item_ticket.destroy
    redirect_to table
  end

  def increase
    table = @item_ticket.ticket.table
    @item_ticket.quantity += 1
    @item_ticket.save
    redirect_to table
  end

  def decrease
    table = @item_ticket.ticket.table
    if (@item_ticket.quantity == 1)
      @item_ticket.destroy
    else
      @item_ticket.quantity -= 1
      @item_ticket.save
    end
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

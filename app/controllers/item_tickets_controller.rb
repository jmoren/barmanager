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

  def delete
    @url = params[:quantity] == "all" ? ticket_destroy_all_ticket_item_tickets_path : ticket_item_ticket_path
    render :delete, layout: false
  end

  def destroy
    reason_id = params.require(:cancel_reason_id)

    ActiveRecord::Base.transaction do
      @item_ticket.update(cancel_reason_id: reason_id)
      @item_ticket.destroy
    end

    redirect_to @ticket
  end

  def deliver
    @item_ticket.update(delivered: true)
    redirect_to :back
  end

  def destroy_all
    reason_id = params.require(:cancel_reason_id)
    items = @ticket.item_tickets.where(item_id: params[:id])

    ActiveRecord::Base.transaction do
      items.update_all(cancel_reason_id: reason_id)
      items.destroy_all
    end

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

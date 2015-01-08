class PromotionTicketsController < ApplicationController
  before_action :set_ticket
  before_action :set_promotion_ticket, only: [:destroy]

  def create
    @promotion_ticket = @ticket.promotion_tickets.new(promotion_ticket_params)
    @promotion_ticket.save
    redirect_to @promotion_ticket.ticket.table
  end

  def destroy
    table = @promotion_ticket.ticket.table
    @promotion_ticket.destroy
    redirect_to table
  end

  private
  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_promotion_ticket
    @promotion_ticket = PromotionTicket.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def promotion_ticket_params
    params.require(:promotion_ticket).permit(:ticket_id, :promotion_id, :quantity)
  end
end

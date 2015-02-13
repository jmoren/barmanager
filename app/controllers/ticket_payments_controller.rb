class TicketPaymentsController < ApplicationController
  before_action :set_ticket
  before_action :set_ticket_payment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def create
    @ticket_payment = @ticket.ticket_payments.new(ticket_payment_params)
    @ticket_payment.save
    redirect_to @ticket.client
  end

  def update
    @ticket_payment.update(ticket_payment_params)
    redirect_to @ticket.client
  end

  def destroy
    @ticket_payment.destroy
    redirect_to @ticket.client
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def set_ticket_payment
      @ticket_payment = @ticket.ticket_payments.find(params[:id])
    end

    def ticket_payment_params
      params.require(:ticket_payment).permit(:ticket_id, :amount)
    end
end

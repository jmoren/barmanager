class TicketPaymentsController < ApplicationController
  before_action :set_client
  before_action :set_ticket_payment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def create
    @ticket_payment = @client.ticket_payments.new(ticket_payment_params)
    @ticket_payment.save
    redirect_to @client
  end

  def update
    @ticket_payment.update(ticket_payment_params)
    redirect_to @client
  end

  def destroy
    @ticket_payment.destroy
    redirect_to @client
  end

  private
    def set_client
      @client = Client.find(params[:client_id])
    end

    def set_ticket_payment
      @ticket_payment = @client.ticket_payments.find(params[:id])
    end

    def ticket_payment_params
      params.require(:ticket_payment).permit(:client_id, :amount).merge(shift_id: Shift.last_open.id)
    end
end

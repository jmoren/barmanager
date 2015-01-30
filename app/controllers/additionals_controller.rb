class AdditionalsController < ApplicationController
  before_action :set_ticket

  def create
    @additional = @ticket.additionals.new(additional_params)
    @additional.save
    dest = @ticket.table || @ticket
    redirect_to dest
  end

  def destroy
    @additional = @ticket.additionals.find(params[:id])
    @additional.destroy
    dest = @ticket.table || @ticket
    redirect_to dest
  end

private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def additional_params
    params.require(:additional).permit(:description, :amount)
  end
end

class AdditionalsController < ApplicationController
  before_action :set_ticket

  def create
    @additional = @ticket.additionals.new(additional_params)
    @additional.save
    redirect_to @ticket
  end

  def destroy
    @additional = @ticket.additionals.find(params[:id])
    reason_id = params.require(:cancel_reason_id)

    ActiveRecord::Base.transaction do
      @additional.update(cancel_reason_id: reason_id)
      @additional.destroy
    end

    redirect_to @ticket
  end

  def deliver
    @additional = @ticket.additionals.find(params[:id])
    @additional.update(delivered: true)

    redirect_to :back
  end

  def delete
    @url = ticket_additional_path
    render :delete, layout: false
  end
private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def additional_params
    params.require(:additional).permit(:description, :amount, :kitchen)
  end
end

class SupplierTicketsController < ApplicationController
  before_action :set_supplier
  before_action :set_supplier_ticket, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @supplier_tickets = @supplier.supplier_tickets.all
    respond_with(@supplier_tickets)
  end

  def create
    @supplier_ticket = @supplier.supplier_tickets.new(supplier_ticket_params)
    @supplier_ticket.save
    redirect_to @supplier
  end

  def destroy
    @supplier_ticket.destroy
    redirect_to @supplier
  end

  private
    def set_supplier
      @supplier = Supplier.find(params[:supplier_id])
    end

    def set_supplier_ticket
      @supplier_ticket = @supplier.supplier_tickets.find(params[:id])
    end

    def supplier_ticket_params
      params.require(:supplier_ticket).permit(:amount, :description, :supplier_id, :shift_id, :code_number)
    end
end

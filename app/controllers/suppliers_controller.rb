class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @suppliers = Supplier.all
    respond_with(@suppliers)
  end

  def show
    @total_payments   = @supplier.expenses.sum(:amount)
    tickets = @supplier.supplier_tickets
    @total_tickets    = tickets.sum(:amount)
    @supplier_tickets = tickets.page params[:page]

    respond_with(@supplier)
  end

  def new
    @supplier = Supplier.new
    respond_with(@supplier)
  end

  def edit
  end

  def create
    @supplier = Supplier.new(supplier_params)
    @supplier.save
    respond_with(@supplier)
  end

  def update
    @supplier.update(supplier_params)
    respond_with(@supplier)
  end

  def destroy
    @supplier.destroy
    respond_with(@supplier)
  end

  private
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    def supplier_params
      params.require(:supplier).permit(:name, :address, :phone)
    end
end

class ItemTicketsController < ApplicationController
  before_action :set_item_ticket, only: [:show, :edit, :update, :destroy]
  before_action :set_ticket
  # GET /item_tickets
  # GET /item_tickets.json
  def index
    @item_tickets = ItemTicket.all
  end

  # GET /item_tickets/1
  # GET /item_tickets/1.json
  def show
  end

  # GET /item_tickets/new
  def new
    @item_ticket = ItemTicket.new
  end

  # GET /item_tickets/1/edit
  def edit
  end

  # POST /item_tickets
  # POST /item_tickets.json
  def create
    @item_ticket = @ticket.item_tickets.new(item_ticket_params)

    respond_to do |format|
      if @item_ticket.save
        format.html { redirect_to @item_ticket.ticket.table, notice: 'Item ticket was successfully created.' }
        format.json { render action: 'show', status: :created}
      else
        format.html { render action: 'new' }
        format.json { render json: @item_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_tickets/1
  # PATCH/PUT /item_tickets/1.json
  def update
    respond_to do |format|
      if @item_ticket.update(item_ticket_params)
        format.html { redirect_to @item_ticket.ticket.table, notice: 'Item ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_tickets/1
  # DELETE /item_tickets/1.json
  def destroy
    table = @item_ticket.ticket.table
    @item_ticket.destroy

    respond_to do |format|
      format.html { redirect_to table }
      format.json { head :no_content }
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item_ticket
      @item_ticket = ItemTicket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_ticket_params
      params.require(:item_ticket).permit(:ticket_id, :item_id, :quantity, :sub_total)
    end
end

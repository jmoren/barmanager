class PromotionItemsController < ApplicationController
  before_action :set_promotion_items, only: [:show, :edit, :update, :destroy]
  before_action :set_promotion
  # GET /item_tickets
  # GET /item_tickets.json
  def index
    @promotion_items = PromotionItems.all
  end

  # GET /item_tickets/1
  # GET /item_tickets/1.json
  def show
  end

  # GET /item_tickets/1/edit
  def edit
  end

  # POST /item_tickets
  # POST /item_tickets.json
  def create
    @promotion_item = @promotion.promotion_items.new(promotion_items_params)

    respond_to do |format|
      if @promotion_item.save
        format.html { redirect_to @promotion_item.promotion}
      else
        format.html {
          redirect_to promotion_path(@promotion_item.promotion, errors: @promotion_item.errors.full_messages)
        }
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
    def set_promotion
      @promotion = Promotion.find(params[:promotion_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_promotion_items
      @promotion_items = PromotionItems.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promotion_items_params
      params.require(:promotion_item).permit(:item_id, :quantity, :promotion_id)
    end
end

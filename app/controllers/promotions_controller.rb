class PromotionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_promotion, only: [:show, :edit, :update, :destroy, :add_item]
  layout "admin"
  # GET /promotions
  # GET /promotions.json
  def index
    if params[:code]
      @promotion = Promotion.where(code: params[:code]).first
      render json: { id: @promotion.try(:id) }
    else
      @promotions = Promotion.all.page params[:page]
    end
  end

  # GET /promotions/1
  # GET /promotions/1.json
  def show
    @promotion.promotion_items.new
  end

  # GET /promotions/new
  def new
    @promotion = Promotion.new
  end

  # GET /promotions/1/edit
  def edit
  end

  # POST /promotions
  # POST /promotions.json
  def create
    @promotion = Promotion.new(promotion_params)

    respond_to do |format|
      if @promotion.save
        format.html { redirect_to @promotion, notice: 'La promocion fue creada, ahora ingrese los productos.' }
        format.json { render action: 'show', status: :created, location: @promotion }
      else
        format.html { render action: 'new' }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /promotions/1
  # PATCH/PUT /promotions/1.json
  def update
    respond_to do |format|
      if @promotion.update(promotion_params)
        format.html { redirect_to @promotion, notice: 'Promotion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.json
  def destroy
    @promotion.destroy
    respond_to do |format|
      format.html { redirect_to promotions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promotion
      @promotion = Promotion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promotion_params
      params.require(:promotion).permit(:description, :day_price, :night_price, :code, :favourite)
    end
end

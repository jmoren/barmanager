class CancelReasonsController < ApplicationController
  before_action :set_cancel_reason, only: [:show, :edit, :update, :destroy]

  # GET /cancel_reasons
  # GET /cancel_reasons.json
  def index
    @cancel_reasons = CancelReason.all
  end

  # GET /cancel_reasons/1
  # GET /cancel_reasons/1.json
  def show
  end

  # GET /cancel_reasons/new
  def new
    @cancel_reason = CancelReason.new
  end

  # GET /cancel_reasons/1/edit
  def edit
  end

  # POST /cancel_reasons
  # POST /cancel_reasons.json
  def create
    @cancel_reason = CancelReason.new(cancel_reason_params)

    respond_to do |format|
      if @cancel_reason.save
        format.html { redirect_to @cancel_reason, notice: 'Cancel reason was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cancel_reason }
      else
        format.html { render action: 'new' }
        format.json { render json: @cancel_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cancel_reasons/1
  # PATCH/PUT /cancel_reasons/1.json
  def update
    respond_to do |format|
      if @cancel_reason.update(cancel_reason_params)
        format.html { redirect_to @cancel_reason, notice: 'Cancel reason was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cancel_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cancel_reasons/1
  # DELETE /cancel_reasons/1.json
  def destroy
    @cancel_reason.destroy
    respond_to do |format|
      format.html { redirect_to cancel_reasons_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cancel_reason
      @cancel_reason = CancelReason.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cancel_reason_params
      params.require(:cancel_reason).permit(:text)
    end
end

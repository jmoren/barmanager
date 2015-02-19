class ShiftsController < ApplicationController
  load_and_authorize_resource
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  layout "admin"

  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Shift.order(created_at: :desc)
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
    @total_tickets     = @shift.total_tickets
    @total_expenses    = @shift.total_expenses
    @total_extractions = @shift.total_extractions
    @total_pending     = @shift.total_pending - @shift.total_payments
    @total_payments    = @shift.total_payments
    @by_items = @shift.count_items
  end

  # GET /shifts/new
  def new
    @shift = Shift.new(open: DateTime.now)
    @last_shift = Shift.order(close: :desc).first
    if @last_shift
      @shift.opening_cash = @last_shift.closing_cash.to_f - @last_shift.total_extractions
    else
      @shift.opening_cash = 0
    end
  end

  # GET /shifts/1/edit
  def edit
  end

  def close
    @shift = Shift.includes(:user).find(params['id'])
    @total_tickets  = @shift.total_tickets
    @total_expenses = @shift.total_expenses
    @total_extractions = @shift.total_extractions
    @total_pending = @shift.total_pending
    @total_payments = @shift.total_payments
    @by_items = @shift.count_items
    @shift.add_closed_data
    url = current_user.admin? ? shifts_path : home_index_path
    respond_to do |format|
      if !@shift.has_open_tickets? && @shift.save
        format.html { redirect_to url, notice: 'Turno cerrado con exito' }
        format.json { render action: 'show', status: :created, location: @shift }
      else
        format.html { render action: 'show' }
        format.json { render json: @shift.errors, status: "No se pudo cerrar el turno. Verifique que no haya mesas abiertas." }
      end
    end
  end

  # POST /shifts
  # POST /shifts.json
  def create
    oc = params[:opening_cash] ? params[:opening_cash] : 0
    @shift = Shift.new(opening_cash: oc)
    @shift.open = DateTime.now
    @shift.user = current_user
    url = current_user.admin? ? @shift : home_index_path
    respond_to do |format|
      if @shift.save
        format.html { redirect_to url, notice: 'Turno abierto con exito' }
        format.json { render action: 'show', status: :created, location: @shift }
      else
        format.html { render action: 'new' }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift.destroy
    respond_to do |format|
      format.html { redirect_to shifts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.includes(:user).find(params[:id])
    end
end

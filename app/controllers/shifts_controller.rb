class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Shift.all
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
    @partial = @shift.tickets.sum(:total) if @shift.is_open?
    item_tickets = ItemTicket.where(ticket_id: @shift.tickets.map(&:id))
    @by_items = {}
    item_tickets.each do |it|
      item = it.item
      @by_items[item.description] = { total: 0, subtotal: 0 } if @by_items[item.description].nil?
      @by_items[item.description][:total]    += it.quantity
      @by_items[item.description][:subtotal] += it.sub_total
    end
  end

  # GET /shifts/new
  def new
    @shift = Shift.new(open: DateTime.now)
  end

  # GET /shifts/1/edit
  def edit
  end

  def close
    @shift = Shift.find(params['id'])
    @total_shift = Ticket.where(shift_id: @shift.id).sum(:total)
    @shift.closing_cash = @total_shift
    @shift.close = DateTime.now

    respond_to do |format|
      if !@shift.has_open_tables? && @shift.save
        format.html { redirect_to @shift, notice: 'Turno cerrado con exito' }
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
    @shift = Shift.new(shift_params)
    @shift.open = DateTime.now

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: 'Turno abierto con exito' }
        format.json { render action: 'show', status: :created, location: @shift }
      else
        format.html { render action: 'new' }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
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
      @shift = Shift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.require(:shift).permit(:open, :close, :opening_cash, :closing_cash)
    end
end
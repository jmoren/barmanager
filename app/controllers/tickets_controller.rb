class TicketsController < ApplicationController
  load_and_authorize_resource

  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :unlink_table]

  # GET /tickets
  # GET /tickets.json
  def index
    if params[:table_id]
      @table   = Table.find(params[:table_id])
      @tickets = Ticket.where(table_id: params[:table_id]).order(created_at: :desc).page params[:page]
    else
      if params[:q].present? && params[:q] == 'noTable'
        @tickets = Ticket.without_table.order(created_at: :desc).page params[:page]
      else
        @tickets = Ticket.all.order(created_at: :desc).page params[:page]
      end
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @ticket.date     = Time.now
    @ticket.total    = 0
    @ticket.status   = "open"
    @ticket.shift    = Shift.last_open
    @ticket.save
    redirect_to @ticket
  end

  # GET /tickets/1/edit
  def edit
    render :layout => request.xhr? ? false : true
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket creado con exito.' }
        format.json { render action: 'show', status: :created, location: @ticket }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    dest = @ticket.table || @ticket
    respond_to do |format|
      if @ticket.update(ticket_params)
        @ticket.table.close!
        format.html { redirect_to dest , notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    if params[:table_id]
      table = Table.find(params[:table_id])
      table.close!
      url = table_path(table)
    else
      url = tickets_path
    end

    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to url }
      format.json { head :no_content }
    end
  end

  def move_to
    @ticket = Ticket.find(params[:id])
    new_table = params[:new_table]
    @table = Table.find(params[:ticket][:table_id])

    if @table.open?
      msg = "La mesa ya esta abierta con un ticket"
    else
      old_table = @ticket.table
      @ticket.update(table_id: @table.id)
      @table.open!(@ticket)
      old_table.close! if old_table

      msg = "Se movio el ticket a la mesa #{@table.name}"
    end

    flash[:notice] = msg
    redirect_to @ticket.table
  end

  def close
    if @ticket.has_items?
      @ticket.close!
    else
      @ticket.destroy
    end
    redirect_to tickets_path(q: 'noTable')
  end

  def unlink_table
    table = @ticket.table
    @ticket.update(table_id: nil)
    table.close! if table
    redirect_to @ticket.open? ? @ticket : tickets_path
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:table_id, :date, :total, :payment, :number, :status)
    end
end

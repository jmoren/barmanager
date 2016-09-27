class TicketsController < ApplicationController
  load_and_authorize_resource

  before_action :set_ticket, only: [:print, :show, :edit, :update, :destroy, :unlink_table, :close_ticket, :unlink_client]

  def print
    params.require(:ticket_type)
    params.require(:id)

    iva = params[:iva] || 21.00
    discount = params[:discount] || 0
    discount_desc = params[:discount_desc] || ""
    payment_desc = params[:payment_desc] || "Cierre Ticket"
    payment = params[:payment] || 0

    RubyPython.start
    epson = RubyPython.import("pyfiscalprinter.epsonFiscal")
    conn = epson.EpsonPrinter.new("epson", "tm-220-af", "COM1")

    unless(conn.nil?)
      conn.open.openBillTicket(params[:ticket_type],
        params[:customer_name], params[:customer_address],
        params[:customer_doc_nbr], params[:customer_doc_type], params[:iva_type])

      @ticket.item_tickets.each do |it|
        item = it.item
        conn.addItem(item.description, it.quantity, item.price, iva, discount, discount_desc)
      end

      conn.addPayment(payment_desc, payment)

      conn.closeDocument.rubify
      #return success code.
    else
      # return error message.
    end

    RubyPython.stop
  end
  # GET /tickets
  # GET /tickets.json
  def index
    if params[:table_id]
      @table   = Table.find(params[:table_id])
      @tickets = Ticket.where(table_id: params[:table_id]).order(status: :desc, created_at: :desc).page params[:page]
    else
      if params[:q].present? && params[:q] == 'noTable'
        @tickets = Ticket.without_table.order(status: :desc, created_at: :desc).page params[:page]
      else
        @tickets = Ticket.order(status: :desc, created_at: :desc).page params[:page]
      end
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new(date: Time.now, total: 0, status: 'open')
    if params[:client_id]
      @ticket.client_id = params[:client_id]
    end

    if @ticket.save
      redirect_to @ticket
    else
      redirect home_index_path, alert: "Error creando ticket"
    end
  end

  # GET /tickets/1/edit
  def edit
    @clients = Client.all
    render layout: request.xhr? ? false : true
  end

  def close_ticket
    render 'close', layout: request.xhr? ? false : true
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
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket , notice: 'Ticket was successfully updated.' }
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
    if @ticket.table
      table = @ticket.table
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

  def deliver_all_kitchen
    @ticket = Ticket.find(params[:id])
    @ticket.deliver_all_kitchen
    render json: @ticket, status: 200

    rescue => error
      render json: error, status: 500
  end

  def move_to
    @ticket = Ticket.find(params[:id])
    @table  = Table.find(params[:ticket][:table_id])

    if @table.open?
      msg = "La mesa ya esta abierta con un ticket"
    else
      old_table = @ticket.table
      if @ticket.update(table_id: @table.id)
        @table.open!(@ticket)
        old_table.close! if old_table

        msg = "Se movio el ticket a la mesa #{@table.name}"
      end
    end

    flash[:notice] = msg
    redirect_to @ticket
  end

  def close
    if @ticket.has_items?
      @ticket.close!(params[:ticket][:credit])
      redirect_to @ticket
    else
      @ticket.destroy
      redirect_to tickets_path
    end
  end

  def unlink_table
    table = @ticket.table
    @ticket.update(table_id: nil)
    table.close! if table
    redirect_to @ticket
  end

  def unlink_client
    @ticket.update(client_id: nil)
    redirect_to @ticket
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:table_id, :client_id, :shift_id, :date, :total, :payment, :number, :status, :credit)
    end
end

class TablesController < ApplicationController
  load_and_authorize_resource

  before_action :set_table, only: [:show, :edit, :update, :destroy, :open, :close]

  # GET /tables
  # GET /tables.json
  def index
    @tables = Table.order(description: :desc)
  end

  def change
    if params[:ticket_id]
      @ticket = Ticket.find(params[:ticket_id])
      @tables = Table.where(status: "closed")
      render 'change', layout: false
    end
  end

  # GET /tables/1
  # GET /tables/1.json
  def show
    if @current_shift && params['status'] == "open"
      @table.open! unless @table.status == "open"
      redirect_to @table.current_ticket
    end
    @current_ticket = @table.tickets.where(status: 'open').last
  end

  # GET /tables/new
  def new
    @table = Table.new
  end

  # GET /tables/1/edit
  def edit
  end

  # POST /tables
  # POST /tables.json
  def create
    @table = Table.new(table_params)
    @table.status = "closed"
    respond_to do |format|
      if @table.save
        format.html { redirect_to @table, notice: 'Table was successfully created.' }
        format.json { render action: 'show', status: :created, location: @table }
      else
        format.html { render action: 'new' }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tables/1
  # PATCH/PUT /tables/1.json
  def update
    respond_to do |format|
      if @table.update(table_params)
        format.html { redirect_to @table, notice: 'Table was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1
  # DELETE /tables/1.json
  def destroy
    @table.destroy
    respond_to do |format|
      format.html { redirect_to home_index_path }
      format.json { head :no_content }
    end
  end

  def open
    if @current_shift
      @table.open! unless @table.status == "open"
      redirect_to @table.current_ticket
    else
      respond_to do |format|
        format.html { redirect_to home_index_path }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def table_params
      params.require(:table).permit(:description, :color)
    end
end

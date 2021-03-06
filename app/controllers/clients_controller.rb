class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  respond_to :html

  def index
    if params[:name]
      @clients = Client.where("LOWER(name) LIKE ?" , "%#{params[:name].downcase}%").page params[:page]
    else
      @clients = Client.all.page params[:page]
    end
    render layout: request.xhr? ? false : 'admin'
  end

  def show
    respond_with(@client)
  end

  def new
    @client = Client.new
    respond_with(@client)
  end

  def edit
  end

  def create
    @client = Client.new(client_params)
    @client.save
    respond_with(@client)
  end

  def update
    @client.update(client_params)
    respond_with(@client)
  end

  def destroy
    @client.destroy
    respond_with(@client)
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name)
    end
end

class StatisticsController < ApplicationController
  before_action :authorize_admin
  layout "admin"
  def index
    if params[:dateFrom] && params[:dateTo]
      from_date = Date.parse(params[:dateFrom]).beginning_of_day
      to_date = Date.parse(params[:dateTo]).end_of_day
      @tickets  = Ticket.where(created_at: from_date..to_date).includes(item_tickets: :item).references(item_tickets: :item)
      @total    = @tickets.sum(:total)
      item_tickets = ItemTicket.includes(:item).where(ticket_id: @tickets.map(&:id))
      @by_items = {}
      item_tickets.each do |it|
        item = it.item
        if item
          @by_items[item.description] = 0 if @by_items[item.description].nil?
          @by_items[item.description] += it.quantity
        end
      end

      @expenses = Expense.where(date: from_date..to_date).group(:supplier).sum(:amount)

    end
  end

  private
  def authorize_admin
    redirect_to home_index_path, alert: "No tenes permisos" unless current_user.admin?
  end
end

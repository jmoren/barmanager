class StatisticsController < ApplicationController
  def index
    if params[:date]
      selected_date = Date.parse(params[:date])
      date  = selected_date.beginning_of_day..selected_date.end_of_day
      @tickets = Ticket.where(created_at: date)
    else
      @tickets = Ticket.all
    end
  end
end

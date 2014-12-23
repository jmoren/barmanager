class StatisticsController < ApplicationController
  def index
    @tickets = Ticket.all
  end
end

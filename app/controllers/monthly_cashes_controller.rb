class MonthlyCashesController < ApplicationController
  load_and_authorize_resource
  layout "admin"

  def index
    @monthly_cashes = MonthlyCash.all.order(date: :desc)
  end

  def show
    @monthly_cash = MonthlyCash.find(params[:id])

    @first_day = @monthly_cash.date.beginning_of_month
    @last_day =  @monthly_cash.date

    @daily_closes = DailyCash.where("date between ? and ?", @first_day, @last_day)
  end

  def close_month
    @last_monthly = MonthlyCash.last_closed || MonthlyCash.new(date: (Date.today - 1.month).end_of_month)

    @first_day = @last_monthly.date + 1.day
    @last_day = @first_day.end_of_month
    @monthly_cash = MonthlyCash.find_or_create_by(date: @last_day)
    @daily_closes = DailyCash.where("date between ? and ?", @first_day, @last_day)

    @monthly_cash.total_expenses = @daily_closes.sum(:total_expenses)
    @monthly_cash.total = @daily_closes.sum(:total)
    @monthly_cash.date = @last_day
    @monthly_cash.save

    render 'show'
  end

  def close
    monthly_cash = MonthlyCash.find(params[:id])
    monthly_cash.update(close: true)
    redirect_to monthly_cash
  end
end
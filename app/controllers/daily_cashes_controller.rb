class DailyCashesController < ApplicationController
  load_and_authorize_resource

  def index
    @daily_cashes = DailyCash.all.order(date: :desc)
  end

  def show
    @daily_cash = DailyCash.find(params[:id])
    @last_closed_daily_cash = DailyCash.where(date: @daily_cash.date - 1.day).first || DailyCash.new(total: 0)
    @shifts = Shift.joins(:user).where('shifts.created_at BETWEEN ? AND ?', @daily_cash.date.beginning_of_day, @daily_cash.date.end_of_day)

  end

  def show_daily_cash
    @last_closed_daily_cash = DailyCash.where(close: true).last || DailyCash.new(date: DateTime.now - 1.day, total: 0)
    date = @last_closed_daily_cash.date + 1.day

    last_daily_cash = DailyCash.last
    if last_daily_cash && last_daily_cash.date.to_date == Date.today
      @daily_cash = last_daily_cash
    else
      @daily_cash = DailyCash.create(date: date)
    end

    @shifts = Shift.joins(:user).where('shifts.created_at BETWEEN ? AND ?', date.beginning_of_day, date.end_of_day)
    @daily_cash.total = @shifts.sum(:closing_cash)

    render 'show'
  end

  def close
    daily_cash = DailyCash.find(params[:id])

    @last_closed_daily_cash = DailyCash.where(date: @daily_cash.date - 1.day).first || DailyCash.new(total: 0)

    @shifts = Shift.joins(:user).where('shifts.created_at BETWEEN ? AND ?', daily_cash.date.beginning_of_day, daily_cash.date.end_of_day)

    daily_cash.total = @last_closed_daily_cash.total + @shifts.sum(:closing_cash) - daily_cash.total_expenses

    daily_cash.close = true

    daily_cash.save

    redirect_to daily_cash
  end
end
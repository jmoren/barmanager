class DailyCashesController < ApplicationController
  load_and_authorize_resource

  def index
    @daily_cashes = DailyCash.all.order(date: :desc)
  end

  def show
    @daily_cash = DailyCash.find(params[:id])
    @last_closed_daily_cash = DailyCash.where(date: @daily_cash.date - 1.day).first || DailyCash.new(total: 0)
    @shifts = Shift.joins(:user).where('shifts.created_at BETWEEN ? AND ?', @daily_cash.date.beginning_of_day, @daily_cash.date.end_of_day)
    @total_shifts = @shifts.sum(:closing_cash)
    @users_expenses = Expense.where('expenses.shift_or_user_type = ? AND expenses.created_at BETWEEN ? AND ?', "User", @daily_cash.date.beginning_of_day, @daily_cash.date.end_of_day)
    @total_expenses = @users_expenses.sum(:amount)

  end

  def show_daily_cash
    @last_closed_daily_cash = DailyCash.last_closed || DailyCash.new(date: DateTime.now - 1.day, total: 0)
    date = @last_closed_daily_cash.date + 1.day

    @daily_cash = DailyCash.find_or_create_by(date: date)
    @shifts = Shift.joins(:user).where('shifts.created_at BETWEEN ? AND ?', date.beginning_of_day, date.end_of_day)
    @users_expenses = Expense.where('expenses.shift_or_user_type = ? AND expenses.created_at BETWEEN ? AND ?', "User", date.beginning_of_day, date.end_of_day)
    @total_expenses = @users_expenses.sum(:amount)
    @total_shifts = @shifts.sum(:closing_cash)
    @daily_cash.total = @last_closed_daily_cash.total + @total_shifts - @total_expenses
    @daily_cash.save

    render 'show'
  end

  def close
    daily_cash = DailyCash.find(params[:id])
    @last_closed_daily_cash = DailyCash.where(date: @daily_cash.date - 1.day).first || DailyCash.new(total: 0)
    @shifts = Shift.joins(:user).where('shifts.created_at BETWEEN ? AND ?', daily_cash.date.beginning_of_day, daily_cash.date.end_of_day)

    daily_cash.update(close: true)

    redirect_to daily_cash
  end
end
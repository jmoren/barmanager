class DailyCashesController < ApplicationController
  load_and_authorize_resource
  layout "admin"

  def index
    @daily_cashes = DailyCash.all.order(date: :desc)
  end

  def show
    @daily_cash = DailyCash.find(params[:id])
    @last_closed_daily_cash = DailyCash.where(date: @daily_cash.date - 1.day).first || DailyCash.new(total: 0)
    @shifts = Shift.joins(:user).where('shifts.created_at BETWEEN ? AND ?', @daily_cash.date.beginning_of_day, @daily_cash.date.end_of_day)
    @total_shifts = @shifts.sum(&:total_tickets)
    @users_expenses = Expense.where('expenses.shift_or_user_type = ? AND expenses.date = ?', "User", @daily_cash.date)
    @total_expenses = @users_expenses.sum(:amount)
    @open_shift_count = @shifts.select { |sh| sh.is_open? }.count

  end

  def show_daily_cash
    @last_closed_daily_cash = DailyCash.last_closed || DailyCash.new(date: DateTime.now - 1.day, total: 0)
    date = @last_closed_daily_cash.date + 1.day

    if (date > Date.today)
      redirect_to @last_closed_daily_cash
    else
      @daily_cash = DailyCash.find_or_create_by(date: date)
      @shifts = Shift.joins(:user).where('shifts.open BETWEEN ? AND ?', date.beginning_of_day, date.end_of_day)
      @total_shifts = @shifts.sum(&:total_tickets)
      @users_expenses = Expense.where('expenses.shift_or_user_type = ? AND expenses.date = ?', "User", date)
      @total_expenses = @users_expenses.sum(:amount)
      @daily_cash.total = @shifts.sum(&:total_extractions)
      @daily_cash.total_expenses = @total_expenses
      @daily_cash.save

      @open_shift_count = @shifts.select { |sh| sh.is_open? }.count.to_i

      render 'show'
    end
  end

  def close
    daily_cash = DailyCash.find(params[:id])
    daily_cash.update(close: true)
    redirect_to daily_cash
  end
end